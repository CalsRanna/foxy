import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets('queryVersion 变化（翻页/搜索）时垂直滚动回到第一行', (tester) async {
    final controller = ScrollController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(buildScrollableTable(0, controller));
    await tester.pumpAndSettle();

    // Scroll down a bit
    await tester.drag(find.byType(ShadTable), const Offset(0, -800));
    await tester.pumpAndSettle();
    expect(controller.offset, greaterThan(0));

    // Query version changes → back to the first row
    await tester.pumpWidget(buildScrollableTable(1, controller));
    await tester.pumpAndSettle();
    expect(controller.offset, 0);
  });

  testWidgets('queryVersion 不变（删除/编辑保存）时保持滚动位置', (tester) async {
    final controller = ScrollController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(buildScrollableTable(0, controller));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(ShadTable), const Offset(0, -800));
    await tester.pumpAndSettle();
    expect(controller.offset, greaterThan(0));

    // Data refresh: version unchanged → position kept
    await tester.pumpWidget(buildScrollableTable(0, controller));
    await tester.pumpAndSettle();
    expect(controller.offset, greaterThan(0));
  });

  testWidgets('shrinkWrap 表格传 queryVersion 不抛异常', (tester) async {
    await tester.pumpWidget(buildShrinkWrapTable(0));
    await tester.pumpAndSettle();
    await tester.pumpWidget(buildShrinkWrapTable(1));
    await tester.pumpAndSettle();
  });
}

/// Builds a bounded-height (scrollable) paginated table; [controller] is
/// the external vertical scroll controller.
Widget buildScrollableTable(int queryVersion, ScrollController controller) {
  return ShadApp(
    home: Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          child: FoxyDataTable<int>(
            queryVersion: queryVersion,
            verticalScrollController: controller,
            rows: List.generate(100, (i) => i),
            columns: [
              FoxyTableColumn.fixed(
                label: '编号',
                width: 120,
                cell: (_, value) => Text('行$value'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/// Builds a shrinkWrap (non-scrolling) table, verifying the params do not
/// throw.
Widget buildShrinkWrapTable(int queryVersion) {
  return ShadApp(
    home: Scaffold(
      body: Center(
        child: FoxyDataTable<int>(
          queryVersion: queryVersion,
          shrinkWrap: true,
          rows: List.generate(3, (i) => i),
          columns: [
            FoxyTableColumn.fixed(
              label: '编号',
              width: 120,
              cell: (_, value) => Text('行$value'),
            ),
          ],
        ),
      ),
    ),
  );
}
