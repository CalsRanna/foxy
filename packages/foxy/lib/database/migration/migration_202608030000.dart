import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/database/migration_runner.dart';
import 'package:laconic/laconic.dart';
import 'package:warcrafty/warcrafty.dart';

/// Legacy DBC tables previously created unsigned fields as signed columns
/// (see `_sqlType` in dbc_import_worker): uint32 flags with the high bit
/// set (≥2^31) were stored as negative numbers, the UI showed negative
/// values, and editing wowhead-style positive values failed with 1264. This
/// migration restores the data table by table and alters the columns to
/// UNSIGNED.
class Migration202608030000 implements Migration {
  @override
  String get name => 'migration_202608030000';

  @override
  Future<void> migrate(Laconic laconic) async {
    for (final definition in DbcDefinitions.all) {
      final unsignedColumns = definition.schema.fields
          .where(
            (field) =>
                field.type == FieldType.uint32 ||
                field.type == FieldType.uint64,
          )
          .toList();
      if (unsignedColumns.isEmpty) continue;
      final tableCount = await laconic
          .table('information_schema.tables')
          .where('table_schema', 'foxy')
          .where('table_name', definition.tableName)
          .count();
      if (tableCount == 0) continue; // skip DBC tables never imported

      for (final column in unsignedColumns) {
        final columnCount = await laconic
            .table('information_schema.columns')
            .where('table_schema', 'foxy')
            .where('table_name', definition.tableName)
            .where('column_name', column.name)
            .count();
        if (columnCount == 0) continue;
        if (column.type == FieldType.uint32) {
          // Data must be restored before ALTER: writing negatives into an
          // UNSIGNED column fails immediately with 1264.
          await laconic.statement(
            'update foxy.`${definition.tableName}` set '
            '`${column.name}` = `${column.name}` + 4294967296 '
            'where `${column.name}` < 0',
          );
          await laconic.statement(
            'alter table foxy.`${definition.tableName}` '
            'modify `${column.name}` int unsigned',
          );
        } else {
          // uint64 is read back as int64, so legacy data cannot hold
          // negatives; just widen the column type.
          await laconic.statement(
            'alter table foxy.`${definition.tableName}` '
            'modify `${column.name}` bigint unsigned',
          );
        }
      }
    }
  }
}
