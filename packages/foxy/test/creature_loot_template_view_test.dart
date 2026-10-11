import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_loot_template_entity.dart';
import 'package:foxy/page/creature_template/creature_loot_template_view.dart';
import 'package:foxy/repository/creature_loot_template_repository.dart';
import 'package:foxy/view_model/creature_loot_template_linked_list_view_model.dart';
import 'package:foxy/widget/foxy_icon_text.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() async => GetIt.instance.reset());

  testWidgets('击杀掉落行在名称前渲染物品图标，关联掉落行保持占位文本', (tester) async {
    tester.view.physicalSize = const Size(1600, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    GetIt.instance.registerSingleton<CreatureLootTemplateRepository>(
      _FakeCreatureLootTemplateRepository(),
    );
    GetIt.instance.registerFactory(
      () => CreatureLootTemplateLinkedListViewModel(),
    );

    await tester.pumpWidget(
      const ShadApp(home: Scaffold(body: CreatureLootTemplateView(linkKey: 1))),
    );
    await tester.pump();
    await tester.pump();

    expect(tester.takeException(), isNull);

    // 普通掉落行：图标 + 名称（名称用 locale 名）
    final iconText = tester.widget<FoxyIconText>(find.byType(FoxyIconText));
    expect(iconText.iconPath, 'Interface\\Icons\\INV_Misc_Foo');
    expect(iconText.name, '测试物品');

    // 关联掉落行：保留灰色占位文本，不渲染图标
    expect(find.text('关联掉落'), findsOneWidget);
    expect(find.byType(FoxyIconText), findsOneWidget);
  });
}

class _FakeCreatureLootTemplateRepository
    extends CreatureLootTemplateRepository {
  @override
  Future<int> countCreatureLootTemplates(int entry) async => 2;

  @override
  Future<List<BriefCreatureLootTemplateEntity>> getBriefCreatureLootTemplates(
    int entry, {
    int page = 1,
  }) async => const [
    BriefCreatureLootTemplateEntity(
      entry: 1,
      item: 100,
      itemName: 'Test Item',
      itemLocaleName: '测试物品',
      itemQuality: 4,
      itemIcon: 'Interface\\Icons\\INV_Misc_Foo',
    ),
    BriefCreatureLootTemplateEntity(entry: 1, item: 90001, reference: 90001),
  ];
}
