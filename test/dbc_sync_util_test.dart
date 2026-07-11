import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/util/dbc_export_util.dart';
import 'package:foxy/util/dbc_sync_progress.dart';
import 'package:foxy/util/dbc_sync_util.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:path/path.dart' as p;

void main() {
  const mysql = MysqlConfig(
    database: 'unused',
    username: 'unused',
    password: 'unused',
  );

  test('DBC 导入：目录不存在时发出唯一失败结果并关闭流', () async {
    final util = DbcSyncUtil();
    final missingDirectory =
        '${Directory.systemTemp.path}/foxy_missing_${DateTime.now().microsecondsSinceEpoch}';

    final events = await util
        .import(directory: missingDirectory, mysqlConfig: mysql)
        .toList()
        .timeout(const Duration(seconds: 5));

    final results = events.whereType<DbcSyncResult>().toList();
    expect(results, hasLength(1));
    expect(results.single.success, isFalse);
    expect(results.single.errors.single.message, contains('目录不存在'));
    expect(util.isRunning, isFalse);
    expect(util.operation, isNull);
  });

  test('DBC 导入：已有任务运行时防重入并返回错误', () async {
    final util = DbcSyncUtil();
    final missingDirectory =
        '${Directory.systemTemp.path}/foxy_missing_${DateTime.now().microsecondsSinceEpoch}';

    final first = util.import(directory: missingDirectory, mysqlConfig: mysql);
    final secondEvents = await util
        .import(directory: missingDirectory, mysqlConfig: mysql)
        .toList()
        .timeout(const Duration(seconds: 5));

    final secondResult = secondEvents.whereType<DbcSyncResult>().single;
    expect(secondResult.success, isFalse);
    expect(secondResult.errors.single.message, contains('已有 DBC 任务正在运行'));

    await first.toList().timeout(const Duration(seconds: 5));
    expect(util.isRunning, isFalse);
  });

  test('DBC 导出：空定义列表立即成功', () async {
    final util = DbcSyncUtil();
    final events = await util
        .export(
          definitions: const [],
          outputDirectory: Directory.systemTemp.path,
          loadRows: (_) async => [],
        )
        .toList()
        .timeout(const Duration(seconds: 5));

    final result = events.whereType<DbcSyncResult>().single;
    expect(result.success, isTrue);
    expect(result.completed, 0);
    expect(result.skipped, 0);
    expect(util.isRunning, isFalse);
  });

  test('DBC 导出：空表跳过且不生成文件', () async {
    final util = DbcSyncUtil();
    final dir = await Directory.systemTemp.createTemp('foxy_export_skip_');
    final definition = dbcDefinitionByTable['dbc_spell_duration']!;
    addTearDown(() async {
      if (await dir.exists()) await dir.delete(recursive: true);
    });

    final events = await util
        .export(
          definitions: [definition],
          outputDirectory: dir.path,
          loadRows: (_) async => [],
        )
        .toList()
        .timeout(const Duration(seconds: 5));

    final result = events.whereType<DbcSyncResult>().single;
    expect(result.success, isTrue);
    expect(result.completed, 0);
    expect(result.skipped, 1);
    expect(await File(p.join(dir.path, definition.fileName)).exists(), isFalse);
  });

  test('DBC 导出：部分失败时保留可汇总错误且任务结束', () async {
    final util = DbcSyncUtil();
    final dir = await Directory.systemTemp.createTemp('foxy_export_partial_');
    final ok = dbcDefinitionByTable['dbc_spell_duration']!;
    final bad = dbcDefinitionByTable['dbc_spell_icon']!;
    addTearDown(() async {
      if (await dir.exists()) await dir.delete(recursive: true);
    });

    final events = await util
        .export(
          definitions: [ok, bad],
          outputDirectory: dir.path,
          loadRows: (table) async {
            if (table == ok.tableName) {
              return [
                {
                  'ID': 1,
                  'Duration': 1,
                  'DurationPerLevel': 0,
                  'MaxDuration': 1,
                },
              ];
            }
            // 缺少 TextureFilename → 导出失败
            return [
              {'ID': 1},
            ];
          },
        )
        .toList()
        .timeout(const Duration(seconds: 10));

    final result = events.whereType<DbcSyncResult>().single;
    expect(result.success, isFalse);
    expect(result.completed, 1);
    expect(result.errors, isNotEmpty);
    expect(result.errors.any((e) => e.fileName == bad.fileName), isTrue);
    expect(await File(p.join(dir.path, ok.fileName)).exists(), isTrue);
    expect(await File(p.join(dir.path, bad.fileName)).exists(), isFalse);
    expect(util.isRunning, isFalse);
  });

  test('DBC 导出：已有任务运行时防重入', () async {
    final util = DbcSyncUtil();
    final dir = await Directory.systemTemp.createTemp('foxy_export_busy_');
    final definition = dbcDefinitionByTable['dbc_spell_duration']!;
    addTearDown(() async {
      if (await dir.exists()) await dir.delete(recursive: true);
    });

    final first = util.export(
      definitions: [definition],
      outputDirectory: dir.path,
      loadRows: (_) async {
        await Future<void>.delayed(const Duration(milliseconds: 200));
        return [
          {'ID': 1, 'Duration': 1, 'DurationPerLevel': 0, 'MaxDuration': 1},
        ];
      },
    );

    final second = await util
        .export(
          definitions: [definition],
          outputDirectory: dir.path,
          loadRows: (_) async => [],
        )
        .toList()
        .timeout(const Duration(seconds: 5));

    expect(
      second.whereType<DbcSyncResult>().single.errors.single.message,
      contains('已有 DBC 任务正在运行'),
    );
    await first.toList().timeout(const Duration(seconds: 5));
  });

  test('DBC 导入：扩展名大小写不敏感扫描', () async {
    final util = DbcSyncUtil();
    final dir = await Directory.systemTemp.createTemp('foxy_import_case_');
    addTearDown(() async {
      if (await dir.exists()) await dir.delete(recursive: true);
    });

    final definition = dbcDefinitionByTable['dbc_spell_duration']!;
    await DbcExportUtil().write(
      definition: definition,
      rows: [
        {'ID': 1, 'Duration': 1, 'DurationPerLevel': 0, 'MaxDuration': 1},
      ],
      outputDirectory: dir.path,
    );

    final lower = File(p.join(dir.path, definition.fileName));
    final upper = File(p.join(dir.path, 'SpellDuration.DBC'));
    await lower.rename(upper.path);

    final events = await util
        .import(directory: dir.path, mysqlConfig: mysql)
        .toList()
        .timeout(const Duration(seconds: 15));

    final result = events.whereType<DbcSyncResult>().single;
    final text = result.errors.map((e) => e.message).join('\n');
    // 扫描成功后才会进入数据库连接；不应仍是「未找到 DBC 文件」。
    expect(text, isNot(contains('未在目录中找到需要的 DBC 文件')));
  }, skip: Platform.isWindows ? 'Windows 文件系统大小写不敏感，无法可靠构造 .DBC 与 .dbc 差异' : false);

  test('DBC 导入：同一定义匹配多个文件时报错', () async {
    final util = DbcSyncUtil();
    final dir = await Directory.systemTemp.createTemp('foxy_import_dup_');
    addTearDown(() async {
      if (await dir.exists()) await dir.delete(recursive: true);
    });

    final definition = dbcDefinitionByTable['dbc_spell_duration']!;
    await DbcExportUtil().write(
      definition: definition,
      rows: [
        {'ID': 1, 'Duration': 1, 'DurationPerLevel': 0, 'MaxDuration': 1},
      ],
      outputDirectory: dir.path,
    );
    await File(
      p.join(dir.path, definition.fileName),
    ).copy(p.join(dir.path, 'SpellDuration.DBC'));

    final events = await util
        .import(directory: dir.path, mysqlConfig: mysql)
        .toList()
        .timeout(const Duration(seconds: 15));

    final result = events.whereType<DbcSyncResult>().single;
    expect(result.success, isFalse);
    expect(
      result.errors.map((e) => e.message).join('\n'),
      contains('多个'),
    );
  }, skip: Platform.isWindows ? 'Windows 文件系统大小写不敏感，无法并存 .dbc 与 .DBC' : false);
}
