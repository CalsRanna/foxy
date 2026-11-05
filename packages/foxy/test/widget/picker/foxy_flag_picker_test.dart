import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:foxy/widget/picker/foxy_flag_picker.dart';
import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets('Checkbox 多选只修改草稿，确定后提交组合值', (tester) async {
    final controller = FlagFieldController()..init(4);
    await _openPicker(tester, controller);

    await tester.tap(find.byType(ShadCheckbox).at(0));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ShadCheckbox).at(1));
    await tester.pumpAndSettle();
    expect(controller.collect(), 4);

    await tester.tap(find.text('确定'));
    await tester.pumpAndSettle();
    expect(controller.collect(), 7);
  });

  testWidgets('双击立即提交该行的标志值，不混入其他已选标志', (tester) async {
    final controller = FlagFieldController()..init(4);
    await _openPicker(tester, controller);

    await tester.tap(find.text('标志一'));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('标志一'));
    await tester.pumpAndSettle();

    expect(controller.collect(), 1);
    expect(find.byType(ShadDialog), findsNothing);
  });

  testWidgets('取消丢弃勾选草稿', (tester) async {
    final controller = FlagFieldController()..init(4);
    await _openPicker(tester, controller);

    await tester.tap(find.text('标志一'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('取消'));
    await tester.pumpAndSettle();

    expect(controller.collect(), 4);
  });
}

Future<void> _openPicker(
  WidgetTester tester,
  FlagFieldController controller,
) async {
  addTearDown(() async {
    await tester.pumpWidget(const SizedBox());
    controller.dispose();
  });
  await tester.pumpWidget(
    ShadApp(
      home: Scaffold(
        body: FoxyFlagPicker(
          controller: controller,
          title: '选择标志',
          flags: const [
            FlagItem(1, '标志一'),
            FlagItem(2, '标志二'),
            FlagItem(4, '标志三'),
          ],
        ),
      ),
    ),
  );
  await tester.tap(find.byIcon(LucideIcons.settings2));
  await tester.pumpAndSettle();
}
