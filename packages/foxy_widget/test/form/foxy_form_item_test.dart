import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy_widget/foxy_widget.dart';

void main() {
  testWidgets('Form labels allow up to six Chinese characters of width', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FoxyFormItem(label: '一二三四五六', child: SizedBox()),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'Form labels wider than six Chinese characters trigger an assertion',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FoxyFormItem(label: '一二三四五六七', child: SizedBox()),
          ),
        ),
      );

      expect(tester.takeException(), isA<AssertionError>());
    },
  );
}
