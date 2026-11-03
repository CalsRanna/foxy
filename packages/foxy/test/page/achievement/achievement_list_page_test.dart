import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/page/achievement/achievement_list_page.dart';
import 'package:foxy/repository/achievement_repository.dart';
import 'package:foxy/view_model/achievement_list_view_model.dart';
import 'package:foxy/widget/foxy_icon_text.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() async => GetIt.instance.reset());

  testWidgets('成就列表的标题列显示 SpellIcon 图标', (tester) async {
    tester.view.physicalSize = const Size(1600, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    GetIt.instance.registerSingleton<AchievementRepository>(
      _FakeAchievementRepository(),
    );
    GetIt.instance.registerFactory(() => AchievementListViewModel());

    await tester.pumpWidget(
      const ShadApp(home: Scaffold(body: AchievementListPage())),
    );
    await tester.pump();
    await tester.pump();

    expect(tester.takeException(), isNull);

    final iconText = tester.widget<FoxyIconText>(find.byType(FoxyIconText));
    expect(iconText.iconPath, 'Interface\\Icons\\Achievement_Boss_Ragnaros');
    expect(iconText.name, '干掉拉格纳罗斯');
  });
}

class _FakeAchievementRepository extends AchievementRepository {
  @override
  Future<int> countAchievements({AchievementFilter? filter}) async => 1;

  @override
  Future<List<BriefAchievementEntity>> getBriefAchievements({
    int page = 1,
    AchievementFilter? filter,
  }) async => const [
    BriefAchievementEntity(
      id: 100,
      titleLangZhCN: '干掉拉格纳罗斯',
      textureFilename: 'Interface\\Icons\\Achievement_Boss_Ragnaros',
    ),
  ];
}
