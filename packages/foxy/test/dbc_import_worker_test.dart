import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/dbc/dbc_import_worker.dart';
import 'package:foxy/infrastructure/dbc/dbc_row_order.dart';

void main() {
  test('导入 INSERT 列清单以隐藏行序列列结尾', () {
    expect(
      dbcImportInsertColumns(['ID', 'TabID', 'TierID']),
      '`ID`, `TabID`, `TierID`, `__dbc_order`',
    );
    expect(dbcImportInsertColumns(const []), '`__dbc_order`');
    expect(
      dbcImportInsertColumns(const []),
      contains(dbcRowOrderColumn),
    );
  });

  test('导入值元组在末尾携带记录的原文件位置', () {
    expect(dbcImportValueTuple(['1', "'abc'", 'NULL'], 7), "(1,'abc',NULL,7)");
    expect(dbcImportValueTuple(const ['1'], 0), '(1,0)');
  });
}
