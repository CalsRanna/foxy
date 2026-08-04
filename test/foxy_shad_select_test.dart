import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets('选中项始终单行显示并在超宽时省略', (tester) async {
    final controller = SelectFieldController<int>(fallback: 0)..init(1);

    await tester.pumpWidget(
      ShadApp(
        home: SizedBox(
          width: 80,
          child: FoxyShadSelect<int>(
            controller: controller,
            options: const {1: '这是一个很长的下拉选项'},
            placeholder: const Text('请选择'),
          ),
        ),
      ),
    );

    final selectedText = tester
        .widgetList<Text>(find.text('这是一个很长的下拉选项'))
        .singleWhere((text) => text.maxLines == 1);
    expect(selectedText.softWrap, isFalse);
    expect(selectedText.overflow, TextOverflow.ellipsis);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox());
    controller.dispose();
  });

  testWidgets('当前值不在 options 中时显示原始整数', (tester) async {
    final controller = SelectFieldController<int>(fallback: 0)..init(42);

    await tester.pumpWidget(
      ShadApp(
        home: FoxyShadSelect<int>(
          controller: controller,
          options: const {1: '选项 A', 2: '选项 B'},
          placeholder: const Text('请选择'),
        ),
      ),
    );

    // An unknown value present in the DB but missing from options: show
    // the raw integer instead of falling back to the first option.
    expect(find.text('42'), findsOneWidget);
    expect(find.text('选项 A'), findsNothing);

    await tester.pumpWidget(const SizedBox());
    controller.dispose();
  });

  testWidgets('点击选项后 controller 值更新', (tester) async {
    final controller = SelectFieldController<int>(fallback: 0)..init(0);

    await tester.pumpWidget(
      ShadApp(
        home: FoxyShadSelect<int>(
          controller: controller,
          options: const {0: '选项 0', 1: '选项 1'},
          placeholder: const Text('请选择'),
        ),
      ),
    );

    await tester.tap(find.text('选项 0'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('选项 1').last);
    await tester.pumpAndSettle();

    expect(controller.collect(), 1);

    await tester.pumpWidget(const SizedBox());
    controller.dispose();
  });

  testWidgets('enabled: false 时点击不打开选项列表', (tester) async {
    final controller = SelectFieldController<int>(fallback: 0)..init(0);

    await tester.pumpWidget(
      ShadApp(
        home: FoxyShadSelect<int>(
          controller: controller,
          options: const {0: '选项 0', 1: '选项 1'},
          placeholder: const Text('请选择'),
          enabled: false,
        ),
      ),
    );

    await tester.tap(find.text('选项 0'), warnIfMissed: false);
    await tester.pumpAndSettle();

    // While disabled the popover never opens; option text must not appear
    // in the overlay.
    expect(find.text('选项 1'), findsNothing);
    expect(controller.collect(), 0);

    await tester.pumpWidget(const SizedBox());
    controller.dispose();
  });
}
