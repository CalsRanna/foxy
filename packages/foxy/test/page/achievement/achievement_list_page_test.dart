import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/page/achievement/achievement_list_page.dart';
import 'package:foxy/repository/achievement_repository.dart';
import 'package:foxy/view_model/achievement_list_view_model.dart';
import 'package:foxy_widget/foxy_widget.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() async => GetIt.instance.reset());

  testWidgets('The achievement title column displays the SpellIcon icon', (
    tester,
  ) async {
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

    final create = tester.widget<ShadButton>(
      find.widgetWithText(ShadButton, '新增'),
    );
    expect(create.leading, isNull);

    final iconText = tester.widget<FoxyIconText>(find.byType(FoxyIconText));
    expect(iconText.iconPath, 'Interface\\Icons\\Achievement_Boss_Ragnaros');
    expect(iconText.name, '干掉拉格纳罗斯');
  });

  testWidgets('Pressing enter in a filter input triggers search', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1600, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final repo = _FakeAchievementRepository();
    GetIt.instance.registerSingleton<AchievementRepository>(repo);
    GetIt.instance.registerFactory(() => AchievementListViewModel());

    await tester.pumpWidget(
      const ShadApp(home: Scaffold(body: AchievementListPage())),
    );
    await tester.pumpAndSettle();

    expect(repo.filters, hasLength(1));

    final inputs = find.byType(EditableText);
    await tester.enterText(inputs.at(1), '拉格纳罗斯');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();

    expect(repo.filters, hasLength(2));
    expect(repo.filters.last?.title, '拉格纳罗斯');
  });
}

class _FakeAchievementRepository extends AchievementRepository {
  final filters = <AchievementFilter?>[];

  @override
  Future<int> countAchievements({AchievementFilter? filter}) async => 1;

  @override
  Future<List<BriefAchievementEntity>> getBriefAchievements({
    int page = 1,
    AchievementFilter? filter,
  }) async {
    filters.add(filter);
    return const [
      BriefAchievementEntity(
        id: 100,
        titleLangZhCN: '干掉拉格纳罗斯',
        textureFilename: 'Interface\\Icons\\Achievement_Boss_Ragnaros',
      ),
    ];
  }
}
