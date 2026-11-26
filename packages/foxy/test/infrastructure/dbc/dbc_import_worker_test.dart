import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/dbc/dbc_import_worker.dart';
import 'package:foxy/infrastructure/dbc/dbc_row_order.dart';

void main() {
  test('The import INSERT column list ends with the hidden row position', () {
    expect(
      DbcImportWorker.insertColumns(['ID', 'TabID', 'TierID']),
      '`ID`, `TabID`, `TierID`, `__dbc_order`',
    );
    expect(DbcImportWorker.insertColumns(const []), '`__dbc_order`');
    expect(
      DbcImportWorker.insertColumns(const []),
      contains(DbcRowOrder.column),
    );
  });

  test(
    'The import values tuple ends with the record\'s original file position',
    () {
      expect(
        DbcImportWorker.valueTuple(['1', "'abc'", 'NULL'], 7),
        "(1,'abc',NULL,7)",
      );
      expect(DbcImportWorker.valueTuple(const ['1'], 0), '(1,0)');
    },
  );
}
