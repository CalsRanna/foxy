import 'package:flutter/material.dart';
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
            placeholder: '请选择',
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
          placeholder: '请选择',
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
          placeholder: '请选择',
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

  testWidgets('搜索中文文案过滤选项', (tester) async {
    final controller = SelectFieldController<int>(fallback: 0)..init(1);

    await tester.pumpWidget(
      ShadApp(
        home: FoxyShadSelect<int>(
          controller: controller,
          options: const {1: '苹果', 2: '香蕉', 3: '菠萝'},
          placeholder: '请选择',
        ),
      ),
    );

    await tester.tap(find.text('苹果'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(EditableText), '香');
    await tester.pumpAndSettle();

    // Only the matching label remains in the list; the trigger keeps
    // showing the selected value (苹果) and non-matching options are gone.
    expect(find.text('香蕉'), findsOneWidget);
    expect(find.text('苹果'), findsOneWidget);
    expect(find.text('菠萝'), findsNothing);

    await tester.pumpWidget(const SizedBox());
    controller.dispose();
  });

  testWidgets('搜索实际的值过滤选项', (tester) async {
    final controller = SelectFieldController<int>(fallback: 0)..init(1);

    await tester.pumpWidget(
      ShadApp(
        home: FoxyShadSelect<int>(
          controller: controller,
          options: const {1: '苹果', 21: '香蕉'},
          placeholder: '请选择',
        ),
      ),
    );

    await tester.tap(find.text('苹果'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(EditableText), '21');
    await tester.pumpAndSettle();

    // Value 21 matches even though the label 香蕉 does not contain "21".
    expect(find.text('香蕉'), findsOneWidget);
    expect(find.text('苹果'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), '999');
    await tester.pumpAndSettle();
    expect(find.text('香蕉'), findsNothing);
    expect(find.text('无匹配选项'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    controller.dispose();
  });

  testWidgets('清空搜索恢复全部选项', (tester) async {
    final controller = SelectFieldController<int>(fallback: 0)..init(1);

    await tester.pumpWidget(
      ShadApp(
        home: FoxyShadSelect<int>(
          controller: controller,
          options: const {1: '苹果', 2: '香蕉', 3: '菠萝'},
          placeholder: '请选择',
        ),
      ),
    );

    await tester.tap(find.text('苹果'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(EditableText), '香');
    await tester.pumpAndSettle();
    expect(find.text('菠萝'), findsNothing);

    await tester.enterText(find.byType(EditableText), '');
    await tester.pumpAndSettle();
    expect(find.text('香蕉'), findsOneWidget);
    expect(find.text('菠萝'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    controller.dispose();
  });

  testWidgets('选中过滤后的选项更新 controller 且关闭后搜索重置', (tester) async {
    final controller = SelectFieldController<int>(fallback: 0)..init(1);

    await tester.pumpWidget(
      ShadApp(
        home: FoxyShadSelect<int>(
          controller: controller,
          options: const {1: '苹果', 2: '香蕉', 3: '菠萝'},
          placeholder: '请选择',
        ),
      ),
    );

    await tester.tap(find.text('苹果'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(EditableText), '香');
    await tester.pumpAndSettle();
    await tester.tap(find.text('香蕉'));
    await tester.pumpAndSettle();

    expect(controller.collect(), 2);

    // Reopening shows the full list again: the search was cleared on close.
    await tester.tap(find.text('香蕉'));
    await tester.pumpAndSettle();
    expect(find.text('苹果'), findsOneWidget);
    expect(find.text('菠萝'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    controller.dispose();
  });
}
