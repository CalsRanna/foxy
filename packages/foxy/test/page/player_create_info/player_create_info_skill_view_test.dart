import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/player_create_info_skill_entity.dart';
import 'package:foxy/page/player_create_info/player_create_info_skill_view.dart';
import 'package:foxy/repository/player_create_info_skill_repository.dart';
import 'package:foxy/view_model/player_create_info_skill_linked_list_view_model.dart';
import 'package:foxy/widget/foxy_icon_text.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() async => GetIt.instance.reset());

  testWidgets('初始技能表格新增技能名称列，带图标；skill 为 0 时不显示图标', (tester) async {
    tester.view.physicalSize = const Size(1600, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    GetIt.instance.registerSingleton<PlayerCreateInfoSkillRepository>(
      _FakePlayerCreateInfoSkillRepository(),
    );
    GetIt.instance.registerFactory(
      () => PlayerCreateInfoSkillLinkedListViewModel(),
    );

    await tester.pumpWidget(
      const ShadApp(
        home: Scaffold(
          body: PlayerCreateInfoSkillView(race: 1, playerClass: 1),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(tester.takeException(), isNull);

    expect(find.text('技能名称'), findsOneWidget);
    final iconText = tester.widget<FoxyIconText>(find.byType(FoxyIconText));
    expect(iconText.iconPath, 'Interface\\Icons\\Trade_Tailoring');
    expect(iconText.name, '裁缝');
    // 第二条技能 ID 为 0，只显示 '-'（不渲染占位图标）
    expect(find.byType(FoxyIconText), findsOneWidget);
  });
}

class _FakePlayerCreateInfoSkillRepository
    extends PlayerCreateInfoSkillRepository {
  @override
  Future<int> countPlayerCreateInfoSkills(int raceMask, int classMask) async =>
      2;

  @override
  Future<List<BriefPlayerCreateInfoSkillEntity>> getBriefPlayerCreateInfoSkills(
    int raceMask,
    int classMask, {
    int page = 1,
  }) async => const [
    BriefPlayerCreateInfoSkillEntity(
      raceMask: 1,
      classMask: 1,
      skill: 197,
      rank: 1,
      skillName: '裁缝',
      textureFilename: 'Interface\\Icons\\Trade_Tailoring',
    ),
    BriefPlayerCreateInfoSkillEntity(raceMask: 1, classMask: 1),
  ];
}
