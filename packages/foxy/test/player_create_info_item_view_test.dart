import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/player_create_info_item_entity.dart';
import 'package:foxy/page/player_create_info/player_create_info_item_view.dart';
import 'package:foxy/repository/player_create_info_item_repository.dart';
import 'package:foxy/view_model/player_create_info_item_linked_list_view_model.dart';
import 'package:foxy/widget/foxy_icon_text.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() async => GetIt.instance.reset());

  testWidgets('初始物品表格新增物品名称列，显示图标与品质色', (tester) async {
    tester.view.physicalSize = const Size(1600, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    GetIt.instance.registerSingleton<PlayerCreateInfoItemRepository>(
      _FakePlayerCreateInfoItemRepository(),
    );
    GetIt.instance.registerFactory(
      () => PlayerCreateInfoItemLinkedListViewModel(),
    );

    await tester.pumpWidget(
      const ShadApp(
        home: Scaffold(body: PlayerCreateInfoItemView(race: 1, playerClass: 1)),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(tester.takeException(), isNull);

    expect(find.text('物品名称'), findsOneWidget);
    final iconText = tester.widget<FoxyIconText>(find.byType(FoxyIconText));
    expect(iconText.iconPath, 'Interface\\Icons\\INV_Misc_Food');
    expect(iconText.name, '测试初始物品');
  });
}

class _FakePlayerCreateInfoItemRepository
    extends PlayerCreateInfoItemRepository {
  @override
  Future<int> countPlayerCreateInfoItems(int race, int class_) async => 1;

  @override
  Future<List<BriefPlayerCreateInfoItemEntity>> getBriefPlayerCreateInfoItems(
    int race,
    int class_, {
    int page = 1,
  }) async => const [
    BriefPlayerCreateInfoItemEntity(
      race: 1,
      class_: 1,
      itemId: 500,
      amount: 5,
      note: '',
      itemName: 'Test Item',
      itemLocaleName: '测试初始物品',
      itemQuality: 2,
      itemIcon: 'Interface\\Icons\\INV_Misc_Food',
    ),
  ];
}
