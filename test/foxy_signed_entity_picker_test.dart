import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/entity/game_object_template_entity.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/repository/game_object_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_signed_entity_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    GetIt.instance.registerSingleton<CreatureTemplateRepository>(
      _FakeCreatureRepository(),
    );
    GetIt.instance.registerSingleton<GameObjectTemplateRepository>(
      _FakeGameObjectRepository(),
    );
  });

  tearDown(() async => GetIt.instance.reset());

  testWidgets('空值打开生物选择器，选择后回填正 ID', (tester) async {
    final controller = IntFieldController()..init(0);

    await tester.pumpWidget(
      _wrap(
        FoxySignedEntityPicker(
          controller: controller,
          positiveSource: SignedEntitySources.creature,
          negativeSource: SignedEntitySources.gameObject,
        ),
      ),
    );

    await tester.tap(find.byIcon(LucideIcons.search));
    await tester.pumpAndSettle();
    expect(find.text('生物模板'), findsOneWidget);

    await tester.tap(find.text('某某生物'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ShadButton, '确定'));
    await tester.pumpAndSettle();

    expect(controller.collect(), 2034);
  });

  testWidgets('负数打开游戏对象选择器，选择后回填负 ID', (tester) async {
    final controller = IntFieldController()..init(-300);

    await tester.pumpWidget(
      _wrap(
        FoxySignedEntityPicker(
          controller: controller,
          positiveSource: SignedEntitySources.creature,
          negativeSource: SignedEntitySources.gameObject,
        ),
      ),
    );

    await tester.tap(find.byIcon(LucideIcons.search));
    await tester.pumpAndSettle();
    expect(find.text('游戏对象模板'), findsOneWidget);

    await tester.tap(find.text('某某门'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ShadButton, '确定'));
    await tester.pumpAndSettle();

    expect(controller.collect(), -555);
  });
}

Widget _wrap(Widget child) {
  return ShadApp(home: Scaffold(body: child));
}

class _FakeCreatureRepository extends CreatureTemplateRepository {
  @override
  Future<List<BriefCreatureTemplateEntity>> getBriefCreatureTemplates({
    int page = 1,
    CreatureTemplateFilter? filter,
  }) async => const [BriefCreatureTemplateEntity(entry: 2034, name: '某某生物')];

  @override
  Future<int> countCreatureTemplates({CreatureTemplateFilter? filter}) async =>
      1;
}

class _FakeGameObjectRepository extends GameObjectTemplateRepository {
  @override
  Future<List<BriefGameObjectTemplateEntity>> getBriefGameObjectTemplates({
    int page = 1,
    GameObjectTemplateFilter? filter,
  }) async => const [BriefGameObjectTemplateEntity(entry: 555, name: '某某门')];

  @override
  Future<int> countGameObjectTemplates({
    GameObjectTemplateFilter? filter,
  }) async => 1;
}
