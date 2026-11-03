import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/model/form/integer_field_spec.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:foxy/widget/picker/foxy_enum_picker.dart';
import 'package:foxy/widget/dialog/foxy_form_dialog.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

const _options = {1: '苹果', 21: '香蕉', 3: '菠萝'};

void main() {
  testWidgets('未初始化显示占位文字，不将 fallback 写入选择', (tester) async {
    final controller = EnumFieldController<int>(fallback: 1);
    await _pumpPicker(tester, controller);
    expect(_input(tester).controller!.text, isEmpty);
    expect(find.text('请选择'), findsOneWidget);
    await _open(tester);
    expect(find.text('当前值: 未选择'), findsOneWidget);
    expect(_confirmButton(tester).enabled, isFalse);
    await tester.tap(find.text('取消'));
    await tester.pumpAndSettle();
    expect(controller.controller.value, isNull);
    expect(controller.collect(), 1);
    await _dispose(tester, controller);
  });

  testWidgets('外部清空单值状态后恢复占位文字和未选择状态', (tester) async {
    final controller = EnumFieldController<int>(fallback: 1)..init(21);
    await _pumpPicker(tester, controller);
    expect(_input(tester).controller!.text, '香蕉');

    controller.controller.value = null;
    await tester.pumpAndSettle();
    expect(_input(tester).controller!.text, isEmpty);
    expect(find.text('请选择'), findsOneWidget);
    expect(controller.collect(), 1);

    await _open(tester);
    expect(find.text('当前值: 未选择'), findsOneWidget);
    expect(_confirmButton(tester).enabled, isFalse);
    await tester.tap(find.text('取消'));
    await tester.pumpAndSettle();
    await _dispose(tester, controller);
  });

  testWidgets('窄字段显示长名称时保持单行且无溢出', (tester) async {
    final controller = EnumFieldController<int>(fallback: 0)..init(1);
    await _pumpPicker(
      tester,
      controller,
      width: 100,
      options: const {1: '这是一个很长的枚举选项名称'},
    );
    expect(_input(tester).controller!.text, '这是一个很长的枚举选项名称');
    expect(_input(tester).maxLines, 1);
    expect(tester.takeException(), isNull);
    await _dispose(tester, controller);
  });

  testWidgets('未知值显示原值，打开和取消不改变它', (tester) async {
    final controller = EnumFieldController<int>(fallback: 0)..init(42);
    await _pumpPicker(tester, controller);
    expect(_input(tester).controller!.text, '42');
    await _open(tester);
    expect(_confirmButton(tester).enabled, isFalse);
    await tester.tap(find.text('取消'));
    await tester.pumpAndSettle();
    expect(controller.collect(), 42);
    await _dispose(tester, controller);
  });

  testWidgets('单击只修改草稿，确定后写回并通知一次', (tester) async {
    final controller = EnumFieldController<int>(fallback: 0)..init(1);
    var changes = 0;
    controller.addListener(() => changes++);
    await _pumpPicker(tester, controller);
    await _open(tester);
    await tester.tap(find.text('香蕉'));
    await tester.pumpAndSettle();
    expect(controller.collect(), 1);
    expect(changes, 0);
    await tester.tap(find.text('确定'));
    await tester.pumpAndSettle();
    expect(controller.collect(), 21);
    expect(changes, 1);
    expect(_input(tester).controller!.text, '香蕉');
    expect(find.byType(ShadDialog), findsNothing);
    await _dispose(tester, controller);
  });

  testWidgets('双击提交选中的值', (tester) async {
    final controller = EnumFieldController<int>(fallback: 0)..init(1);
    await _pumpPicker(tester, controller);
    await _open(tester);
    await tester.tap(find.text('香蕉'));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('香蕉'));
    await tester.pumpAndSettle();
    expect(controller.collect(), 21);
    expect(find.byType(ShadDialog), findsNothing);
    await _dispose(tester, controller);
  });

  for (final close in ['取消', 'Esc', '遮罩']) {
    testWidgets('$close 丢弃草稿，不通知字段监听器', (tester) async {
      final controller = EnumFieldController<int>(fallback: 0)..init(1);
      var changes = 0;
      controller.addListener(() => changes++);
      await _pumpPicker(tester, controller);
      await _open(tester);
      await tester.tap(find.text('香蕉'));
      await tester.pumpAndSettle();
      switch (close) {
        case '取消':
          await tester.tap(find.text('取消'));
        case 'Esc':
          await tester.sendKeyEvent(LogicalKeyboardKey.escape);
        case '遮罩':
          await tester.tapAt(const Offset(5, 5));
      }
      await tester.pumpAndSettle();
      expect(find.byType(ShadDialog), findsNothing);
      expect(controller.collect(), 1);
      expect(changes, 0);
      expect(_input(tester).focusNode!.hasFocus, isTrue);
      await _dispose(tester, controller);
    });
  }

  testWidgets('按名称和值搜索，清空及重新打开恢复全部选项', (tester) async {
    final controller = EnumFieldController<int>(fallback: 0)..init(1);
    await _pumpPicker(tester, controller);
    await _open(tester);
    await tester.enterText(_search, ' 香 ');
    await tester.pumpAndSettle();
    expect(find.text('香蕉'), findsOneWidget);
    expect(find.text('菠萝'), findsNothing);
    await tester.enterText(_search, '21');
    await tester.pumpAndSettle();
    expect(find.text('香蕉'), findsOneWidget);
    await tester.enterText(_search, '999');
    await tester.pumpAndSettle();
    expect(find.text('无匹配选项'), findsOneWidget);
    expect(_confirmButton(tester).enabled, isFalse);
    await tester.enterText(_search, '');
    await tester.pumpAndSettle();
    expect(find.text('菠萝'), findsOneWidget);
    await tester.enterText(_search, '香蕉');
    await tester.pumpAndSettle();
    await tester.tap(find.text('香蕉').last);
    await tester.pump();
    await tester.tap(find.text('确定'));
    await tester.pumpAndSettle();
    await _open(tester);
    expect(find.text('菠萝'), findsOneWidget);
    expect(tester.widget<EditableText>(_search).controller.text, isEmpty);
    await _dispose(tester, controller);
  });

  testWidgets('外部初始化、选项更新与 controller 替换同步显示', (tester) async {
    final first = EnumFieldController<int>(fallback: 0)..init(1);
    final second = EnumFieldController<int>(fallback: 0)..init(3);
    await _pumpPicker(tester, first);
    first.init(21);
    await tester.pump();
    expect(_input(tester).controller!.text, '香蕉');
    await _pumpPicker(tester, first, options: const {21: '新名称'});
    expect(_input(tester).controller!.text, '新名称');
    await _pumpPicker(tester, first, options: const {1: '苹果'});
    expect(_input(tester).controller!.text, '21');
    await _pumpPicker(tester, second);
    first.init(1);
    await tester.pump();
    expect(_input(tester).controller!.text, '菠萝');
    await _dispose(tester, first);
    second.dispose();
  });

  testWidgets('字符串枚举搜索忽略大小写并提交字符串值', (tester) async {
    final controller = EnumFieldController<String>(fallback: 'a')..init('a');
    await _pumpPicker(
      tester,
      controller,
      options: const {'a': 'Alpha', 'B': 'Beta'},
    );
    await _open(tester);
    await tester.enterText(_search, 'b');
    await tester.pumpAndSettle();
    expect(find.text('Beta'), findsOneWidget);
    await tester.tap(find.text('Beta'));
    await tester.pump();
    await tester.tap(find.text('确定'));
    await tester.pumpAndSettle();
    expect(controller.collect(), 'B');
    await _dispose(tester, controller);
  });

  testWidgets('键盘打开、搜索、上下选择、回车提交并恢复焦点', (tester) async {
    final controller = EnumFieldController<int>(fallback: 0)..init(1);
    await _pumpPicker(tester, controller);
    _input(tester).focusNode!.requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(tester.widget<EditableText>(_search).focusNode.hasFocus, isTrue);
    await tester.enterText(_search, '香');
    await tester.pumpAndSettle();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(controller.collect(), 21);
    expect(_input(tester).focusNode!.hasFocus, isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.pumpAndSettle();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(controller.collect(), 1);
    await _dispose(tester, controller);
  });

  testWidgets('长列表键盘选择保持选中行可见', (tester) async {
    final controller = EnumFieldController<int>(fallback: 0)..init(0);
    await _pumpPicker(
      tester,
      controller,
      options: {for (var i = 0; i < 60; i++) i: '选项 $i'},
    );
    await _open(tester);
    for (var i = 0; i < 20; i++) {
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();
    }
    expect(find.text('选项 20').hitTestable(), findsOneWidget);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(controller.collect(), 20);
    await _dispose(tester, controller);
  });

  testWidgets('焦点在取消按钮时回车取消而非提交', (tester) async {
    final controller = EnumFieldController<int>(fallback: 0)..init(1);
    await _pumpPicker(tester, controller);
    await _open(tester);
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    await tester.pump();
    final cancel = find.widgetWithText(ShadButton, '取消');
    Focus.of(tester.element(find.text('取消'))).requestFocus();
    await tester.pump();
    expect(cancel, findsOneWidget);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(find.byType(ShadDialog), findsNothing);
    expect(controller.collect(), 1);
    await _dispose(tester, controller);
  });

  testWidgets('空选项无匹配且无法确认', (tester) async {
    final controller = EnumFieldController<int>(fallback: 0)..init(42);
    await _pumpPicker(tester, controller, options: const <int, String>{});
    await _open(tester);
    expect(find.text('无匹配选项'), findsOneWidget);
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(find.byType(ShadDialog), findsOneWidget);
    expect(controller.collect(), 42);
    await _dispose(tester, controller);
  });

  testWidgets('动态整数分组只在确认后同步其他编辑器', (tester) async {
    final group = IntFieldControllerGroup()..init(1);
    group.configure(IntegerFieldEditor.enumValue);
    await _pumpPicker(tester, group.enumController);
    await _open(tester);
    await tester.tap(find.text('香蕉'));
    await tester.pumpAndSettle();
    expect(group.collect(), 1);
    expect(group.numberController.collect(), 1);
    await tester.tap(find.text('确定'));
    await tester.pumpAndSettle();
    expect(group.collect(), 21);
    expect(group.numberController.collect(), 21);
    expect(group.flagController.collect(), 21);
    group.configure(IntegerFieldEditor.number);
    expect(group.collect(), 21);
    await tester.pumpWidget(const SizedBox());
    group.dispose();
  });

  testWidgets('嵌套对话框取消及确认只关闭 picker，保留外层草稿', (tester) async {
    final controller = EnumFieldController<int>(fallback: 0)..init(1);
    final draft = TextEditingController(text: '未保存的备注');
    await tester.pumpWidget(
      ShadApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: ShadButton(
              onPressed: () => DialogUtil.show<void>(
                context: context,
                builder: (_) => FoxyFormDialog(
                  title: '编辑记录',
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShadInput(controller: draft),
                      FoxyEnumPicker<int>(
                        controller: controller,
                        options: _options,
                        title: '选择类型',
                      ),
                    ],
                  ),
                ),
              ),
              child: const Text('编辑'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('编辑'));
    await tester.pumpAndSettle();
    await _open(tester);
    await tester.tap(find.text('香蕉'));
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    expect(find.text('编辑记录'), findsOneWidget);
    expect(controller.collect(), 1);
    expect(draft.text, '未保存的备注');
    await _open(tester);
    await tester.tap(find.text('香蕉').last);
    await tester.pump();
    await tester.tap(find.text('确定'));
    await tester.pumpAndSettle();
    expect(find.text('编辑记录'), findsOneWidget);
    expect(controller.collect(), 21);
    expect(draft.text, '未保存的备注');
    await _dispose(tester, controller);
    draft.dispose();
  });
}

Finder get _search => find.descendant(
  of: find.byType(ShadDialog).last,
  matching: find.byType(EditableText),
);

ShadInput _input(WidgetTester tester) => tester.widget<ShadInput>(
  find.byWidgetPredicate((widget) => widget is ShadInput && widget.readOnly),
);

ShadButton _confirmButton(WidgetTester tester) =>
    tester.widget<ShadButton>(find.widgetWithText(ShadButton, '确定'));

Future<void> _pumpPicker<T>(
  WidgetTester tester,
  EnumFieldController<T> controller, {
  Map<T, String>? options,
  double width = 280,
}) async {
  await tester.pumpWidget(
    ShadApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: width,
            child: FoxyEnumPicker<T>(
              controller: controller,
              options: options ?? _options as Map<T, String>,
              title: '选择类型',
              placeholder: '请选择',
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _open(WidgetTester tester) async {
  await tester.tap(find.byIcon(LucideIcons.list));
  await tester.pumpAndSettle();
}

Future<void> _dispose<T>(
  WidgetTester tester,
  EnumFieldController<T> controller,
) async {
  await tester.pumpWidget(const SizedBox());
  controller.dispose();
}
