import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/entity/game_object_template_entity.dart';
import 'package:foxy/model/picker/signed_entity_source.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/repository/game_object_template_repository.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:foxy/widget/picker/delegate/signed_entity_sources.dart';
import 'package:foxy/widget/picker/foxy_signed_entity_picker.dart';
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

  testWidgets('列表与总数并发并共用条件快照，两者完成后才更新结果', (tester) async {
    final controller = IntFieldController()..init(123);
    final pending = <Completer<List<SignedEntityBrief>>>[];
    final pendingCounts = <Completer<int>>[];
    final listQueries = <(String, String)>[];
    final countQueries = <(String, String)>[];
    final source = SignedEntitySource(
      title: '选择实体',
      errorLabel: '查询失败',
      fetch: (page, id, name) {
        listQueries.add((id, name));
        final result = Completer<List<SignedEntityBrief>>();
        pending.add(result);
        return result.future;
      },
      count: (id, name) {
        countQueries.add((id, name));
        final result = Completer<int>();
        pendingCounts.add(result);
        return result.future;
      },
    );
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox());
      controller.dispose();
    });
    await tester.pumpWidget(
      _wrap(
        FoxySignedEntityPicker(
          controller: controller,
          positiveSource: source,
          negativeSource: source,
        ),
      ),
    );
    await tester.tap(find.byIcon(LucideIcons.search));
    await tester.pumpAndSettle();
    expect(listQueries, [('123', '')]);
    expect(countQueries, listQueries);
    final filters = find.descendant(
      of: find.byType(ShadDialog),
      matching: find.byType(EditableText),
    );
    await tester.enterText(filters.at(0), '456');
    await tester.enterText(filters.at(1), '第二次条件');
    pendingCounts[0].complete(1);
    await tester.pumpAndSettle();
    expect(find.text('第一条'), findsNothing);
    pending[0].complete(const [SignedEntityBrief(id: 123, name: '第一条')]);
    await tester.pumpAndSettle();

    expect(listQueries, [('123', '')]);
    expect(countQueries, [('123', '')]);
    expect(find.text('第一条'), findsOneWidget);

    await tester.tap(find.text('查询'));
    await tester.pumpAndSettle();
    expect(listQueries, [('123', ''), ('456', '第二次条件')]);
    expect(countQueries, listQueries);
    await tester.enterText(filters.at(0), '789');
    await tester.enterText(filters.at(1), '尚未查询的草稿');
    pending[1].complete(const [SignedEntityBrief(id: 456, name: '第二条')]);
    await tester.pumpAndSettle();
    expect(find.text('第二条'), findsNothing);
    pendingCounts[1].complete(1);
    await tester.pumpAndSettle();

    expect(listQueries, [('123', ''), ('456', '第二次条件')]);
    expect(countQueries, listQueries);
    expect(find.text('第二条'), findsOneWidget);
    expect(find.text('第一条'), findsNothing);
  });

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
