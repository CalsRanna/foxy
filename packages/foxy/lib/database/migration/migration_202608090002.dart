import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/database/migration_runner.dart';
import 'package:foxy/infrastructure/dbc/dbc_row_order.dart';
import 'package:laconic/laconic.dart';

/// Adds the hidden row-order column to existing DBC tables so export can
/// reproduce the original DBC file order. Order-sensitive DBCs such as
/// Talent.dbc need it — the 3.3.5 client derives the talent-tree layout
/// from the file row order, so exporting rows sorted by ID scrambles every
/// tree. Values stay NULL until the table is re-imported (import writes
/// the file position), which keeps the export order of legacy data
/// unchanged.
class Migration202608090002 implements Migration {
  @override
  String get name => 'migration_202608090002';

  @override
  Future<void> migrate(Laconic laconic) async {
    for (final definition in dbcDefinitions) {
      final tableCount = await laconic
          .table('information_schema.tables')
          .where('table_schema', 'foxy')
          .where('table_name', definition.tableName)
          .count();
      if (tableCount == 0) continue; // skip DBC tables never imported

      final columnCount = await laconic
          .table('information_schema.columns')
          .where('table_schema', 'foxy')
          .where('table_name', definition.tableName)
          .where('column_name', dbcRowOrderColumn)
          .count();
      if (columnCount > 0) continue;

      await laconic.statement(
        'alter table foxy.`${definition.tableName}` '
        'add column `$dbcRowOrderColumn` bigint null',
      );
    }
  }
}
