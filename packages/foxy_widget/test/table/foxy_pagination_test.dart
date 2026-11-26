import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy_widget/foxy_widget.dart';

void main() {
  testWidgets(
    'Four-digit page numbers are fully visible and keep their width when selected',
    (tester) async {
      var page = 999;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: StatefulBuilder(
                builder: (context, setState) => FoxyPagination(
                  page: page,
                  pageSize: 1,
                  total: 1234,
                  onChange: (value) => setState(() => page = value),
                ),
              ),
            ),
          ),
        ),
      );

      for (final label in ['999', '1000', '1234']) {
        final text = find.text(label);
        final paragraph = tester.renderObject<RenderParagraph>(text);
        expect(
          paragraph.size.width,
          greaterThanOrEqualTo(paragraph.getMaxIntrinsicWidth(double.infinity)),
        );
      }

      final pageLabel = find.text('1000');
      final pageButton = find
          .ancestor(of: pageLabel, matching: find.byType(GestureDetector))
          .first;
      final width = tester.getSize(pageButton).width;
      await tester.tap(pageLabel);
      await tester.pump();

      expect(page, 1000);
      expect(tester.getSize(pageButton).width, width);
    },
  );
}
