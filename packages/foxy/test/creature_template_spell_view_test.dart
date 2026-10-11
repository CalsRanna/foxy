import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_template_spell_entity.dart';
import 'package:foxy/page/creature_template/creature_template_spell_view.dart';
import 'package:foxy/repository/creature_template_spell_repository.dart';
import 'package:foxy/view_model/creature_template_spell_linked_list_view_model.dart';
import 'package:foxy/widget/foxy_icon_text.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() async => GetIt.instance.reset());

  testWidgets('生物技能行的技能名称显示法术图标', (tester) async {
    tester.view.physicalSize = const Size(1600, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    GetIt.instance.registerSingleton<CreatureTemplateSpellRepository>(
      _FakeCreatureTemplateSpellRepository(),
    );
    GetIt.instance.registerFactory(
      () => CreatureTemplateSpellLinkedListViewModel(),
    );

    await tester.pumpWidget(
      const ShadApp(
        home: Scaffold(body: CreatureTemplateSpellView(creatureId: 1)),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(tester.takeException(), isNull);

    final iconText = tester.widget<FoxyIconText>(find.byType(FoxyIconText));
    expect(iconText.iconPath, 'Interface\\Icons\\Spell_Fire_FlameBolt');
    expect(iconText.name, '火球术 - 等级 1');
  });
}

class _FakeCreatureTemplateSpellRepository
    extends CreatureTemplateSpellRepository {
  @override
  Future<int> countCreatureTemplateSpells(int creatureID) async => 1;

  @override
  Future<List<BriefCreatureTemplateSpellEntity>> getBriefCreatureTemplateSpells(
    int creatureID, {
    int page = 1,
  }) async => const [
    BriefCreatureTemplateSpellEntity(
      creatureID: 1,
      index: 0,
      spell: 133,
      spellName: '火球术',
      spellSubtext: '等级 1',
      textureFilename: 'Interface\\Icons\\Spell_Fire_FlameBolt',
    ),
  ];
}
