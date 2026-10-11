import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_loot_template_entity.dart';
import 'package:foxy/repository/creature_loot_template_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_icon_text.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() async => GetIt.instance.reset());

  testWidgets('击杀掉落 picker 的普通行显示物品图标，引用行保持纯文本', (tester) async {
    GetIt.instance.registerSingleton<CreatureLootTemplateRepository>(
      _FakeCreatureLootTemplateRepository(),
    );

    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(
          body: FoxyEntityPicker<BriefCreatureLootTemplateEntity>(
            controller: IntFieldController(),
            delegate: FoxyEntityPickerDelegates.creatureLoot,
          ),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.byIcon(LucideIcons.search));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);

    // 普通掉落行：图标 + 名称
    final iconText = tester.widget<FoxyIconText>(find.byType(FoxyIconText));
    expect(iconText.iconPath, 'Interface\\Icons\\INV_Misc_Foo');
    expect(iconText.name, '测试物品');

    // 引用行：保持“引用 #N”纯文本，不渲染图标
    expect(find.text('引用 #90001'), findsOneWidget);
    expect(find.byType(FoxyIconText), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
  });
}

class _FakeCreatureLootTemplateRepository
    extends CreatureLootTemplateRepository {
  @override
  Future<List<BriefCreatureLootTemplateEntity>> getBriefLootTemplateRows({
    CreatureLootTemplateFilter? filter,
    int page = 1,
  }) async => const [
    BriefCreatureLootTemplateEntity(
      entry: 100,
      item: 500,
      itemName: 'Test Item',
      itemLocaleName: '测试物品',
      itemQuality: 4,
      itemIcon: 'Interface\\Icons\\INV_Misc_Foo',
    ),
    BriefCreatureLootTemplateEntity(entry: 100, item: 90001, reference: 90001),
  ];

  @override
  Future<int> countLootTemplateRows({
    CreatureLootTemplateFilter? filter,
  }) async => 2;
}
