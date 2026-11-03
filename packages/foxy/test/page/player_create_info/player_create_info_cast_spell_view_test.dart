import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/player_create_info_cast_spell_entity.dart';
import 'package:foxy/page/player_create_info/player_create_info_cast_spell_view.dart';
import 'package:foxy/repository/player_create_info_cast_spell_repository.dart';
import 'package:foxy/view_model/player_create_info_cast_spell_linked_list_view_model.dart';
import 'package:foxy/widget/foxy_icon_text.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() async => GetIt.instance.reset());

  testWidgets('初始施放法术表格新增法术名称列并显示图标', (tester) async {
    tester.view.physicalSize = const Size(1600, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    GetIt.instance.registerSingleton<PlayerCreateInfoCastSpellRepository>(
      _FakePlayerCreateInfoCastSpellRepository(),
    );
    GetIt.instance.registerFactory(
      () => PlayerCreateInfoCastSpellLinkedListViewModel(),
    );

    await tester.pumpWidget(
      const ShadApp(
        home: Scaffold(
          body: PlayerCreateInfoCastSpellView(race: 1, playerClass: 1),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(tester.takeException(), isNull);

    expect(find.text('法术名称'), findsOneWidget);
    final iconText = tester.widget<FoxyIconText>(find.byType(FoxyIconText));
    expect(iconText.iconPath, 'Interface\\Icons\\Spell_Holy_FlashHeal');
    expect(iconText.name, '快速治疗');
  });
}

class _FakePlayerCreateInfoCastSpellRepository
    extends PlayerCreateInfoCastSpellRepository {
  @override
  Future<int> countPlayerCreateInfoCastSpells(
    int race,
    int playerClass,
  ) async => 1;

  @override
  Future<List<BriefPlayerCreateInfoCastSpellEntity>>
  getBriefPlayerCreateInfoCastSpells(
    int race,
    int playerClass, {
    int page = 1,
  }) async => const [
    BriefPlayerCreateInfoCastSpellEntity(
      raceMask: 1,
      classMask: 1,
      spell: 2061,
      spellName: '快速治疗',
      textureFilename: 'Interface\\Icons\\Spell_Holy_FlashHeal',
    ),
  ];
}
