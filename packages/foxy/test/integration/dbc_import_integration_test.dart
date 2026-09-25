@Tags(['integration'])
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/database/database.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:path/path.dart' as p;
import 'package:warcrafty/warcrafty.dart';

import 'integration_mysql.dart';

/// The DBC import pipeline against a real MySQL: staging table → transaction →
/// row-count/duplicate-ID validation → atomic rename swap, driven through the
/// isolate worker exactly like the app does.
///
/// `SpellIcon.dbc` is the smallest real schema (two fields, one of them a
/// string, so the UTF-8 string-block path is covered). The fixture is produced
/// by [DbcWriter] — the same writer the export workflow uses — so no
/// hand-rolled binary is involved.
///
/// The importer only writes the fixed `foxy.<table>` names and replaces the
/// whole table, so these tests are destructive on a real `foxy` schema and only
/// run with `FOXY_TEST_MYSQL_ALLOW_DBC_WRITE=1` (CI sets it).
///
/// Run with `flutter test --tags integration --run-skipped`.
void main() {
  final definition = DbcDefinitions.byTable['dbc_spell_icon']!;

  late Directory dbcDirectory;
  late String dbcPath;

  /// Skips the calling test (at runtime, so `--run-skipped` cannot bypass the
  /// guard) unless writes into `foxy.dbc_*` are explicitly allowed.
  bool guardDbcWrite() {
    if (allowDbcImportWrite) return true;
    markTestSkipped(
      'set FOXY_TEST_MYSQL_ALLOW_DBC_WRITE=1 to import into foxy.dbc_*',
    );
    return false;
  }

  /// Writes the fixture file the importer looks for: `<schema name>.dbc`.
  void writeDbc(List<List<dynamic>> records) => DbcWriter(
    dbcPath,
    definition.schema.format,
    dialect: definition.schema.dialect,
  ).write(records);

  Future<DbcSyncResult> runImport() async {
    final events = await DbcSyncUtil()
        .import(
          directory: dbcDirectory.path,
          mysqlConfig: integrationMysqlConfig(),
        )
        .toList();
    return events.whereType<DbcSyncResult>().single;
  }

  Future<List<Map<String, dynamic>>> readTable() async {
    final rows = await Database.instance.laconic
        .table(definition.qualifiedTableName)
        .select(['ID', 'TextureFilename', '__dbc_order'])
        .orderBy('__dbc_order')
        .get();
    return rows.map((row) => row.toMap()).toList();
  }

  Future<List<String>> foxyTables() async {
    final rows = await Database.instance.laconic
        .table('information_schema.tables')
        .select(['table_name'])
        .where('table_schema', 'foxy')
        .get();
    return rows.map((row) => row.toMap()['TABLE_NAME'] as String).toList();
  }

  /// A rejected import must leave the live table untouched and must not leave
  /// its staging table behind.
  Future<void> expectRejectedImport({required int leftRows}) async {
    expect(await readTable(), hasLength(leftRows), reason: '失败不得替换原表');
    expect(
      (await foxyTables()).where(
        (name) => name.startsWith('dbc_spell_icon__staging'),
      ),
      isEmpty,
      reason: '失败后应清理 staging 表',
    );
  }

  setUpAll(() async {
    // Create the fixture directory before connecting: when the connection
    // fails, tearDownAll still has something to delete.
    dbcDirectory = await Directory.systemTemp.createTemp('foxy_dbc_import_');
    dbcPath = p.join(dbcDirectory.path, definition.fileName);
    await connectIntegrationDatabase();
    // The importer targets `foxy.<table>`; make sure the schema exists without
    // depending on the migration suite having run first.
    await Database.instance.laconic.statement(
      'create database if not exists foxy '
      'character set utf8mb4 collate utf8mb4_unicode_ci',
    );
  });

  tearDownAll(() async {
    await dbcDirectory.delete(recursive: true);
    await Database.instance.close();
  });

  test('首次导入:按 schema 建表、写入记录并保留文件行序', () async {
    if (!guardDbcWrite()) return;
    await Database.instance.laconic.statement(
      'drop table if exists ${definition.qualifiedTableName}',
    );

    writeDbc([
      [1, 'Interface\\Icons\\Spell_Nature'],
      [2, '中文图标名'],
    ]);
    final result = await runImport();

    expect(result.success, isTrue, reason: result.errors.join(' | '));
    expect(result.completed, 1);
    expect(result.skipped, 0);

    final rows = await readTable();
    expect(rows.map((row) => row['ID']).toList(), [1, 2]);
    expect(rows.map((row) => row['TextureFilename']).toList(), [
      'Interface\\Icons\\Spell_Nature',
      '中文图标名',
    ], reason: 'utf8mb4 往返,含反斜杠路径');
    expect(rows.map((row) => row['__dbc_order']).toList(), [0, 1]);
  });

  test('再次导入:整表替换而非追加,且不留 backup 表', () async {
    if (!guardDbcWrite()) return;

    writeDbc([
      [10, 'a'],
      [20, 'b'],
      [30, 'c'],
    ]);
    expect((await runImport()).success, isTrue);

    writeDbc([
      [99, 'only'],
    ]);
    final second = await runImport();

    expect(second.success, isTrue, reason: second.errors.join(' | '));
    final rows = await readTable();
    expect(rows, hasLength(1), reason: '导入是替换语义');
    expect(rows.single['ID'], 99);

    expect(
      (await foxyTables()).where(
        (name) => name.startsWith('dbc_spell_icon__backup'),
      ),
      isEmpty,
    );
  });

  test('重复 ID:按 schema 建的表(带主键)在写入阶段被拒', () async {
    if (!guardDbcWrite()) return;

    // `_sqlType` maps the ID field to `int not null primary key`, so a table
    // built from the schema rejects a duplicate file on the INSERT itself.
    writeDbc([
      [1, 'good'],
    ]);
    expect((await runImport()).success, isTrue);

    writeDbc([
      [5, 'first'],
      [5, 'second'],
    ]);
    final result = await runImport();

    expect(result.success, isFalse);
    final error = result.errors.single;
    expect(error.stage, DbcSyncStage.writing, reason: error.message);
    await expectRejectedImport(leftRows: 1);
  });

  test('重复 ID:无主键的遗留表在校验阶段被拒', () async {
    if (!guardDbcWrite()) return;

    // A legacy mirror table without the primary key (and without the row-order
    // column) is the only shape where the row-count/distinct-ID validation is
    // what catches duplicates — it also exercises the ALTER that adds
    // `__dbc_order` to a cloned legacy table.
    await Database.instance.laconic.statement(
      'drop table if exists ${definition.qualifiedTableName}',
    );
    await Database.instance.laconic.statement(
      'create table ${definition.qualifiedTableName} ('
      '`ID` int unsigned not null, `TextureFilename` text'
      ') engine=innodb default charset=utf8mb4',
    );

    writeDbc([
      [1, 'good'],
    ]);
    expect((await runImport()).success, isTrue);

    writeDbc([
      [5, 'first'],
      [5, 'second'],
    ]);
    final result = await runImport();

    expect(result.success, isFalse);
    final error = result.errors.single;
    expect(error.stage, DbcSyncStage.validating, reason: error.message);
    expect(error.message, contains('duplicate IDs'));
    await expectRejectedImport(leftRows: 1);
  });

  test('checkTables 报告该表 ready', () async {
    if (!guardDbcWrite()) return;

    writeDbc([
      [7, 'x'],
    ]);
    expect((await runImport()).success, isTrue);

    final checks = await DbcSyncUtil().checkTables();
    final mine = checks.where(
      (check) => check.tableName == definition.tableName,
    );

    expect(mine, hasLength(1));
    expect(mine.single.state, DbcTableState.ready, reason: mine.single.message);
  });
}
