import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/dialog/foxy_form_dialog.dart';
import 'package:foxy/widget/picker/foxy_enum_picker.dart';
import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:foxy_widget/foxy_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets(
    'An uninitialized picker displays a placeholder without committing the fallback',
    (tester) async {
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
    },
  );

  testWidgets(
    'Clearing the value externally restores the unselected placeholder',
    (tester) async {
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
    },
  );

  testWidgets('Long names stay on one line without overflow in narrow fields', (
    tester,
  ) async {
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

  testWidgets(
    'Unknown values display unchanged and survive opening and canceling',
    (tester) async {
      final controller = EnumFieldController<int>(fallback: 0)..init(42);
      await _pumpPicker(tester, controller);
      expect(_input(tester).controller!.text, '42');
      await _open(tester);
      expect(_confirmButton(tester).enabled, isFalse);
      await tester.tap(find.text('取消'));
      await tester.pumpAndSettle();
      expect(controller.collect(), 42);
      await _dispose(tester, controller);
    },
  );

  testWidgets(
    'A click changes only the draft and confirmation commits it with one notification',
    (tester) async {
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
    },
  );

  testWidgets(
    'Radio indicates the sole selection and clicking it or its row only edits the draft',
    (tester) async {
      final controller = EnumFieldController<int>(fallback: 0)..init(1);
      await _pumpPicker(tester, controller);
      await _open(tester);

      final table = tester.widget<FoxyDataTable<MapEntry<int, String>>>(
        find.byType(FoxyDataTable<MapEntry<int, String>>),
      );
      expect(table.selectedKey, isNull);
      expect(find.byType(ShadRadio<int>), findsNWidgets(3));
      expect(_selectedRadioValues(tester), [1]);

      await tester.tap(
        find.byWidgetPredicate((w) => w is ShadRadio<int> && w.value == 21),
      );
      await tester.pumpAndSettle();
      expect(_selectedRadioValues(tester), [21]);
      expect(controller.collect(), 1);

      await tester.tap(find.text('菠萝'));
      await tester.pumpAndSettle();
      expect(_selectedRadioValues(tester), [3]);
      expect(controller.collect(), 1);

      await tester.tap(find.text('确定'));
      await tester.pumpAndSettle();
      expect(controller.collect(), 3);
      await _dispose(tester, controller);
    },
  );

  testWidgets(
    'Filtering out a selected item disables confirmation and clearing the filter does not restore it',
    (tester) async {
      final controller = EnumFieldController<int>(fallback: 0)..init(1);
      await _pumpPicker(tester, controller);
      await _open(tester);

      await tester.enterText(_search, '香蕉');
      await tester.pumpAndSettle();
      expect(_confirmButton(tester).enabled, isFalse);
      await tester.tap(find.text('确定'), warnIfMissed: false);
      expect(find.byType(ShadDialog), findsOneWidget);

      await tester.enterText(_search, '');
      await tester.pumpAndSettle();
      expect(_selectedRadioValues(tester), isEmpty);
      expect(_confirmButton(tester).enabled, isFalse);
      await tester.tap(find.text('取消'));
      await tester.pumpAndSettle();
      expect(controller.collect(), 1);
      await _dispose(tester, controller);
    },
  );

  testWidgets('Double-click commits the selected value', (tester) async {
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

  for (final close in ['Cancel', 'Esc', 'Backdrop']) {
    testWidgets('$close discards the draft without notifying field listeners', (
      tester,
    ) async {
      final controller = EnumFieldController<int>(fallback: 0)..init(1);
      var changes = 0;
      controller.addListener(() => changes++);
      await _pumpPicker(tester, controller);
      await _open(tester);
      await tester.tap(find.text('香蕉'));
      await tester.pumpAndSettle();
      switch (close) {
        case 'Cancel':
          await tester.tap(find.text('取消'));
        case 'Esc':
          await tester.sendKeyEvent(LogicalKeyboardKey.escape);
        case 'Backdrop':
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

  testWidgets(
    'Search matches names and values and clearing or reopening restores all options',
    (tester) async {
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
    },
  );

  testWidgets(
    'External initialization, option changes, and controller replacement update the display',
    (tester) async {
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
    },
  );

  testWidgets('String enum search ignores case and commits the string value', (
    tester,
  ) async {
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

  testWidgets(
    'The primary input does not open the dialog through a separate shortcut',
    (tester) async {
      final controller = EnumFieldController<int>(fallback: 0)..init(1);
      await _pumpPicker(tester, controller);
      for (final key in [
        LogicalKeyboardKey.enter,
        LogicalKeyboardKey.numpadEnter,
        LogicalKeyboardKey.space,
      ]) {
        _input(tester).focusNode!.requestFocus();
        await tester.pump();
        await tester.sendKeyEvent(key);
        await tester.pumpAndSettle();
        expect(find.byType(ShadDialog), findsNothing);
      }
      expect(controller.collect(), 1);
      await _dispose(tester, controller);
    },
  );

  testWidgets(
    'Search arrow keys leave selection alone and neither Enter nor input submission confirms',
    (tester) async {
      final controller = EnumFieldController<int>(fallback: 0)..init(1);
      await _pumpPicker(tester, controller);
      await _open(tester);
      for (final key in [
        LogicalKeyboardKey.arrowDown,
        LogicalKeyboardKey.arrowUp,
        LogicalKeyboardKey.enter,
        LogicalKeyboardKey.numpadEnter,
      ]) {
        tester.widget<EditableText>(_search).focusNode.requestFocus();
        await tester.pump();
        await tester.sendKeyEvent(key);
        await tester.pumpAndSettle();
        expect(_selectedRadioValues(tester), [1]);
        expect(find.byType(ShadDialog), findsOneWidget);
      }
      await tester.tap(_search);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(find.byType(ShadDialog), findsOneWidget);
      expect(controller.collect(), 1);
      await _dispose(tester, controller);
    },
  );

  testWidgets('Radio and Confirm keep their default keyboard behavior', (
    tester,
  ) async {
    final controller = EnumFieldController<int>(fallback: 0)..init(1);
    await _pumpPicker(tester, controller);
    await _open(tester);
    final radio = find.byWidgetPredicate(
      (widget) => widget is ShadRadio<int> && widget.value == 21,
    );
    Focus.of(
      tester.element(
        find.descendant(of: radio, matching: find.byType(ShadDecorator)),
      ),
    ).requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.pumpAndSettle();
    expect(_selectedRadioValues(tester), [21]);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(find.byType(ShadDialog), findsOneWidget);
    expect(controller.collect(), 1);

    Focus.of(tester.element(find.text('确定'))).requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(find.byType(ShadDialog), findsNothing);
    expect(controller.collect(), 21);
    await _dispose(tester, controller);
  });

  testWidgets('Enter on the focused Cancel button cancels without submitting', (
    tester,
  ) async {
    final controller = EnumFieldController<int>(fallback: 0)..init(1);
    await _pumpPicker(tester, controller);
    await _open(tester);
    await tester.tap(find.text('香蕉'));
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

  testWidgets('An empty option list has no matches and cannot be confirmed', (
    tester,
  ) async {
    final controller = EnumFieldController<int>(fallback: 0)..init(42);
    await _pumpPicker(tester, controller, options: const <int, String>{});
    await _open(tester);
    expect(find.text('无匹配选项'), findsOneWidget);
    expect(_confirmButton(tester).enabled, isFalse);
    await tester.tap(find.text('确定'), warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(find.byType(ShadDialog), findsOneWidget);
    expect(controller.collect(), 42);
    await _dispose(tester, controller);
  });

  testWidgets(
    'A dynamic integer group synchronizes other editors only after confirmation',
    (tester) async {
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
    },
  );

  testWidgets(
    'Canceling or confirming a nested picker closes only the picker and preserves the outer draft',
    (tester) async {
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
    },
  );
}

const _options = {1: '苹果', 21: '香蕉', 3: '菠萝'};

Finder get _search => find.descendant(
  of: find.byType(ShadDialog).last,
  matching: find.byType(EditableText),
);

ShadButton _confirmButton(WidgetTester tester) =>
    tester.widget<ShadButton>(find.widgetWithText(ShadButton, '确定'));

Future<void> _dispose<T>(
  WidgetTester tester,
  EnumFieldController<T> controller,
) async {
  await tester.pumpWidget(const SizedBox());
  controller.dispose();
}

ShadInput _input(WidgetTester tester) => tester.widget<ShadInput>(
  find.byWidgetPredicate((widget) => widget is ShadInput && widget.readOnly),
);

Future<void> _open(WidgetTester tester) async {
  await tester.tap(find.byIcon(LucideIcons.list));
  await tester.pumpAndSettle();
}

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

List<int> _selectedRadioValues(WidgetTester tester) => tester
    .elementList(find.byType(ShadRadio<int>))
    .where((element) {
      final group = element
          .findAncestorStateOfType<ShadRadioGroupState<int>>()!;
      return group.effectiveController.value ==
          (element.widget as ShadRadio<int>).value;
    })
    .map((element) => (element.widget as ShadRadio<int>).value)
    .toList();
