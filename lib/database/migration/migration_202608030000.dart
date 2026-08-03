import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/database/migration_runner.dart';
import 'package:laconic/laconic.dart';
import 'package:warcrafty/warcrafty.dart';

/// 存量 DBC 表的无符号字段此前按有符号列建表(见 dbc_import_worker 的
/// `_sqlType`):uint32 flags 高位置位(≥2^31)被存成负数,UI 显示负值、
/// 按 wowhead 正值编辑报 1264。本迁移逐表还原数据并把列改为 UNSIGNED。
class Migration202608030000 implements Migration {
  @override
  String get name => 'migration_202608030000';

  @override
  Future<void> migrate(Laconic laconic) async {
    for (final definition in dbcDefinitions) {
      final unsignedColumns = definition.schema.fields
          .where(
            (field) =>
                field.type == FieldType.uint32 ||
                field.type == FieldType.uint64,
          )
          .toList();
      if (unsignedColumns.isEmpty) continue;
      final tableCount = await laconic
          .table('information_schema.TABLES')
          .where('TABLE_SCHEMA', 'foxy')
          .where('TABLE_NAME', definition.tableName)
          .count();
      if (tableCount == 0) continue; // 未导入过的 DBC 表跳过

      for (final column in unsignedColumns) {
        final columnCount = await laconic
            .table('information_schema.COLUMNS')
            .where('TABLE_SCHEMA', 'foxy')
            .where('TABLE_NAME', definition.tableName)
            .where('COLUMN_NAME', column.name)
            .count();
        if (columnCount == 0) continue;
        if (column.type == FieldType.uint32) {
          // 必须先还原数据再 ALTER:负数写入 UNSIGNED 列会直接报 1264。
          await laconic.statement(
            'UPDATE foxy.`${definition.tableName}` SET '
            '`${column.name}` = `${column.name}` + 4294967296 '
            'WHERE `${column.name}` < 0',
          );
          await laconic.statement(
            'ALTER TABLE foxy.`${definition.tableName}` '
            'MODIFY `${column.name}` INT UNSIGNED',
          );
        } else {
          // uint64 由 int64 读出,存量不可能有负数;直接扩列型。
          await laconic.statement(
            'ALTER TABLE foxy.`${definition.tableName}` '
            'MODIFY `${column.name}` BIGINT UNSIGNED',
          );
        }
      }
    }
  }
}
