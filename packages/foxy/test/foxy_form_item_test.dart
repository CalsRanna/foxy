import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/widget/foxy_form_item.dart';

void main() {
  testWidgets('表单标签最多允许六个汉字宽度', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FoxyFormItem(label: '一二三四五六', child: SizedBox()),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });

  testWidgets('表单标签超过六个汉字宽度时触发断言', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FoxyFormItem(label: '一二三四五六七', child: SizedBox()),
        ),
      ),
    );

    expect(tester.takeException(), isA<AssertionError>());
  });
}
