import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_equip_template_entity.dart';
import 'package:foxy/page/creature_template/creature_equip_template_view.dart';
import 'package:foxy/repository/creature_equip_template_repository.dart';
import 'package:foxy/view_model/creature_equip_template_linked_list_view_model.dart';
import 'package:foxy/widget/foxy_icon_text.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() async => GetIt.instance.reset());

  testWidgets('装备模板行的武器列显示图标，空槽位不显示占位图标', (tester) async {
    tester.view.physicalSize = const Size(1600, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    GetIt.instance.registerSingleton<CreatureEquipTemplateRepository>(
      _FakeCreatureEquipTemplateRepository(),
    );
    GetIt.instance.registerFactory(
      () => CreatureEquipTemplateLinkedListViewModel(),
    );

    await tester.pumpWidget(
      const ShadApp(
        home: Scaffold(body: CreatureEquipTemplateView(creatureId: 1)),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(tester.takeException(), isNull);

    // 主手有物品 → 图标 + 名称；副手/远程为空槽 → 纯文本，无图标
    final iconText = tester.widget<FoxyIconText>(find.byType(FoxyIconText));
    expect(iconText.iconPath, 'Interface\\Icons\\INV_Sword');
    expect(iconText.name, '测试武器');
    expect(find.byType(FoxyIconText), findsOneWidget);
  });
}

class _FakeCreatureEquipTemplateRepository
    extends CreatureEquipTemplateRepository {
  @override
  Future<int> countCreatureEquipTemplates(int creatureID) async => 1;

  @override
  Future<List<BriefCreatureEquipTemplateEntity>> getBriefCreatureEquipTemplates(
    int creatureID, {
    int page = 1,
  }) async => const [
    BriefCreatureEquipTemplateEntity(
      creatureID: 1,
      id: 1,
      itemID1: 500,
      name1: 'Test Sword',
      localeName1: '测试武器',
      quality1: 4,
      icon1: 'Interface\\Icons\\INV_Sword',
    ),
  ];
}
