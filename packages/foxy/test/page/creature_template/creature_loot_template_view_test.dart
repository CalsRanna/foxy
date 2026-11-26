import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_loot_template_entity.dart';
import 'package:foxy/page/creature_template/creature_loot_template_view.dart';
import 'package:foxy/repository/creature_loot_template_repository.dart';
import 'package:foxy/view_model/creature_loot_template_linked_list_view_model.dart';
import 'package:foxy_widget/foxy_widget.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() async => GetIt.instance.reset());

  testWidgets(
    'Kill loot shows an item icon before the name and reference loot keeps placeholder text',
    (tester) async {
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
        const ShadApp(
          home: Scaffold(body: CreatureLootTemplateView(linkKey: 1)),
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(tester.takeException(), isNull);

      // A regular loot row displays the icon and localized name.
      final iconText = tester.widget<FoxyIconText>(find.byType(FoxyIconText));
      expect(iconText.iconPath, 'Interface\\Icons\\INV_Misc_Foo');
      expect(iconText.name, '测试物品');

      // A reference row displays gray placeholder text.
      expect(find.text('关联掉落'), findsOneWidget);
      expect(find.byType(FoxyIconText), findsOneWidget);
    },
  );
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
