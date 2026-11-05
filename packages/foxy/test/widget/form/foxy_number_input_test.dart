import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:foxy/widget/form/foxy_number_input.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets('整数输入保留非法原文，读取时拒绝而不改成其他数值', (tester) async {
    final controller = IntFieldController();
    await _pumpInput(tester, controller);

    for (final text in ['12a', '1.5', '-']) {
      await tester.enterText(find.byType(EditableText), text);

      expect(controller.controller.text, text);
      expect(controller.collect, throwsFormatException);
    }
  });

  testWidgets('浮点输入保留非法原文，读取时拒绝而不改成其他数值', (tester) async {
    final controller = DoubleFieldController();
    await _pumpInput(tester, controller);

    await tester.enterText(find.byType(EditableText), '12a');

    expect(controller.controller.text, '12a');
    expect(controller.collect, throwsFormatException);
  });

  testWidgets('浮点输入保留并正确解析科学计数法', (tester) async {
    final controller = DoubleFieldController();
    await _pumpInput(tester, controller);

    await tester.enterText(find.byType(EditableText), '1e3');
    expect(controller.controller.text, '1e3');
    expect(controller.collect(), 1000.0);

    await tester.enterText(find.byType(EditableText), '-2.5E-3');
    expect(controller.controller.text, '-2.5E-3');
    expect(controller.collect(), -0.0025);
  });
}

Future<void> _pumpInput<T extends num>(
  WidgetTester tester,
  NumberFieldController<T> controller,
) async {
  addTearDown(() async {
    await tester.pumpWidget(const SizedBox());
    controller.dispose();
  });
  await tester.pumpWidget(
    ShadApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 280,
            child: FoxyNumberInput<T>(controller: controller),
          ),
        ),
      ),
    ),
  );
}
