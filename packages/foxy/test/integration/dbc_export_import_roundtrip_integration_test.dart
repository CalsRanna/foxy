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

/// Round trip through both real workers: database rows → `.dbc` (export) →
/// database rows (import, staging + atomic swap).
///
/// It covers what the single-direction suites cannot: the export-side read
/// (row-order-aware `SELECT`, projection to schema fields, `.dbc` writing) and,
/// by comparing the tables before and after, that the two directions agree.
///
/// Rows are seeded with explicit SQL so a row can carry a NULL `__dbc_order`
/// (what app-created records look like) next to rows with a stored file
/// position. Like the import suite this is destructive on the real `foxy`
/// tables, so it only runs with `FOXY_TEST_MYSQL_ALLOW_DBC_WRITE=1`.
///
/// Run with `flutter test --tags integration --run-skipped`.
void main() {
  final definition = DbcDefinitions.byTable['dbc_spell_icon']!;
  final table = definition.qualifiedTableName;

  late Directory exportDirectory;
  late String exportedPath;

  /// Skips the calling test (at runtime, so `--run-skipped` cannot bypass the
  /// guard) unless writes into `foxy.dbc_*` are explicitly allowed.
  bool guardDbcWrite() {
    if (allowDbcImportWrite) return true;
    markTestSkipped(
      'set FOXY_TEST_MYSQL_ALLOW_DBC_WRITE=1 to touch foxy.dbc_*',
    );
    return false;
  }

  Future<DbcSyncResult> runExport() async {
    final events = await DbcSyncUtil()
        .export(
          definitions: [definition],
          outputDirectory: exportDirectory.path,
          mysqlConfig: integrationMysqlConfig(),
        )
        .toList();
    return events.whereType<DbcSyncResult>().single;
  }

  Future<DbcSyncResult> runImport() async {
    final events = await DbcSyncUtil()
        .import(
          directory: exportDirectory.path,
          mysqlConfig: integrationMysqlConfig(),
        )
        .toList();
    return events.whereType<DbcSyncResult>().single;
  }

  /// Two rows carrying a stored file position plus one app-created row whose
  /// `__dbc_order` is NULL.
  Future<void> seedRows() async {
    await Database.instance.laconic.statement('drop table if exists $table');
    await Database.instance.laconic.statement(
      'create table `${definition.tableName}` ('
      '`ID` int unsigned not null, '
      '`TextureFilename` text character set utf8mb4 '
      'collate utf8mb4_unicode_ci, '
      '`__dbc_order` bigint null, '
      'primary key (`ID`)) engine=innodb default charset=utf8mb4',
    );
    await Database.instance.laconic.statement(
      'insert into $table (`ID`, `TextureFilename`, `__dbc_order`) '
      'values (?, ?, ?), (?, ?, ?), (?, ?, null)',
      [3, 'three', 0, 1, '中文一', 1, 2, 'Interface\\Icons\\Spell_Two'],
    );
  }

  Future<List<Map<String, dynamic>>> readTable() async {
    final rows = await Database.instance.laconic
        .table(table)
        .select(['ID', 'TextureFilename', '__dbc_order'])
        .orderBy('__dbc_order')
        .get();
    return rows.map((row) => row.toMap()).toList();
  }

  setUpAll(() async {
    // Create the fixture directory first: a failing connect must still leave
    // tearDownAll something to clean up.
    exportDirectory = await Directory.systemTemp.createTemp('foxy_dbc_export_');
    exportedPath = p.join(exportDirectory.path, definition.fileName);
    await connectIntegrationDatabase();
    await Database.instance.laconic.statement(
      'create database if not exists foxy '
      'character set utf8mb4 collate utf8mb4_unicode_ci',
    );
  });

  tearDownAll(() async {
    await exportDirectory.delete(recursive: true);
    await Database.instance.close();
  });

  test('导出按行序输出,并对缺失行序的表给出提示', () async {
    if (!guardDbcWrite()) return;
    await seedRows();

    final result = await runExport();

    expect(result.success, isTrue, reason: result.errors.join(' | '));
    expect(result.completed, 1);
    expect(result.skipped, 0);
    expect(result.warnings, hasLength(1), reason: '存在行序为 NULL 的行时应提示导出行序可能不正确');
    expect(result.warnings.single.message, contains(definition.fileName));

    final loader = DbcLoader(exportedPath, definition.schema.format);
    final records = loader.records.toList();
    expect(records, hasLength(3));
    expect(records.map((record) => record.getInt(0)).toList(), [
      3,
      1,
      2,
    ], reason: '先按 __dbc_order,再按 ID');
    expect(records.map((record) => record.getString(1)).toList(), [
      'three',
      '中文一',
      'Interface\\Icons\\Spell_Two',
    ]);
  });

  test('往返一致:导出的文件重新导入后内容与行序不变', () async {
    if (!guardDbcWrite()) return;
    await seedRows();
    expect((await runExport()).success, isTrue);

    // Drop the table so the import has to rebuild it from the file alone.
    await Database.instance.laconic.statement('drop table if exists $table');
    final imported = await runImport();

    expect(imported.success, isTrue, reason: imported.errors.join(' | '));
    expect(imported.completed, 1);

    final rows = await readTable();
    expect(rows.map((row) => row['ID']).toList(), [3, 1, 2]);
    expect(rows.map((row) => row['TextureFilename']).toList(), [
      'three',
      '中文一',
      'Interface\\Icons\\Spell_Two',
    ]);
    expect(rows.map((row) => row['__dbc_order']).toList(), [0, 1, 2]);
  });

  test('二次往返字节稳定', () async {
    if (!guardDbcWrite()) return;
    await seedRows();
    expect((await runExport()).success, isTrue);
    final first = File(exportedPath).readAsBytesSync();

    expect((await runImport()).success, isTrue);
    expect((await runExport()).success, isTrue);
    final second = File(exportedPath).readAsBytesSync();

    expect(second, first, reason: '内容与行序都不变时,导出的字节应完全一致');
  });

  test('空表导出被跳过且不产生文件', () async {
    if (!guardDbcWrite()) return;
    if (File(exportedPath).existsSync()) File(exportedPath).deleteSync();
    await Database.instance.laconic.statement('drop table if exists $table');
    await Database.instance.laconic.statement(
      'create table `${definition.tableName}` ('
      '`ID` int unsigned not null, `TextureFilename` text, '
      '`__dbc_order` bigint null) engine=innodb default charset=utf8mb4',
    );

    final result = await runExport();

    expect(result.success, isTrue, reason: result.errors.join(' | '));
    expect(result.completed, 0);
    expect(result.skipped, 1, reason: '空表跳过');
    expect(File(exportedPath).existsSync(), isFalse);
  });
}
