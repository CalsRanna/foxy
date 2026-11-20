import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/page/setting/dbc_export_table_row.dart';
import 'package:foxy/view_model/workflow/dbc_export_item.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets('点击可用行或复选框各触发一次选择，失败行不可选', (tester) async {
    final selection = <bool>[];
    final item = DbcExportItem(definition: DbcDefinitions.all.first);
    final failed = DbcExportItem(
      definition: DbcDefinitions.all[1],
      countError: '计数失败',
      selected: false,
    );
    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(
          body: Column(
            children: [
              DbcExportTableRow(item: item, onChanged: selection.add),
              DbcExportTableRow(item: failed, onChanged: selection.add),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.text(item.dbcFileName));
    expect(selection, [false]);
    await tester.tap(find.byType(Checkbox).first);
    expect(selection, [false, false]);
    await tester.tap(find.text(failed.dbcFileName));
    expect(selection, [false, false]);
    expect(
      tester.widget<Checkbox>(find.byType(Checkbox).last).onChanged,
      isNull,
    );
  });
}
