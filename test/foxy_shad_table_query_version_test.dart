import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets('queryVersion 变化（翻页/搜索）时垂直滚动回到第一行', (tester) async {
    final controller = ScrollController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(buildScrollableTable(0, controller));
    await tester.pumpAndSettle();

    // 向下滚动一段距离
    await tester.drag(find.byType(FoxyShadTable), const Offset(0, -800));
    await tester.pumpAndSettle();
    expect(controller.offset, greaterThan(0));

    // 查询版本变化 → 回到第一行
    await tester.pumpWidget(buildScrollableTable(1, controller));
    await tester.pumpAndSettle();
    expect(controller.offset, 0);
  });

  testWidgets('queryVersion 不变（删除/编辑保存）时保持滚动位置', (tester) async {
    final controller = ScrollController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(buildScrollableTable(0, controller));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(FoxyShadTable), const Offset(0, -800));
    await tester.pumpAndSettle();
    expect(controller.offset, greaterThan(0));

    // 数据型刷新：版本不变 → 位置保持
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

/// 构建有界高度（可滚动）的分页表格，[controller] 为外部垂直滚动控制器。
Widget buildScrollableTable(int queryVersion, ScrollController controller) {
  return ShadApp(
    home: Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          child: FoxyShadTable(
            queryVersion: queryVersion,
            verticalScrollController: controller,
            columnCount: 1,
            rowCount: 100,
            header: (context, column) {
              return ShadTableCell.header(child: Text('编号'));
            },
            builder: (context, vicinity) {
              return ShadTableCell(child: Text('行${vicinity.row}'));
            },
          ),
        ),
      ),
    ),
  );
}

/// 构建 shrinkWrap（无滚动）表格，验证传参不抛异常。
Widget buildShrinkWrapTable(int queryVersion) {
  return ShadApp(
    home: Scaffold(
      body: Center(
        child: FoxyShadTable(
          queryVersion: queryVersion,
          shrinkWrap: true,
          columnCount: 1,
          rowCount: 3,
          header: (context, column) {
            return ShadTableCell.header(child: Text('编号'));
          },
          builder: (context, vicinity) {
            return ShadTableCell(child: Text('行${vicinity.row}'));
          },
        ),
      ),
    ),
  );
}
