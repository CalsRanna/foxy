import 'dart:io';
import 'dart:isolate';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_worker.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:path/path.dart' as p;

void main() {
  const mysql = MysqlConfig(
    database: 'unused',
    username: 'unused',
    password: 'unused',
    useSsl: false,
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
    expect(
      results.single.errors.single.message,
      contains('directory does not exist'),
    );
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
    final util = DbcSyncUtil(exportWorkerEntry: _CancelAwareExportWorker.run);
    final events = await util
        .export(
          definitions: const [],
          outputDirectory: Directory.systemTemp.path,
          mysqlConfig: mysql,
        )
        .toList()
        .timeout(const Duration(seconds: 5));

    final result = events.whereType<DbcSyncResult>().single;
    expect(result.success, isTrue);
    expect(result.completed, 0);
    expect(result.skipped, 0);
    expect(util.isRunning, isFalse);
  });

  test('DBC 导出：已有任务运行时防重入', () async {
    final util = DbcSyncUtil(exportWorkerEntry: _CancelAwareExportWorker.run);
    final dir = await Directory.systemTemp.createTemp('foxy_export_busy_');
    final definition = DbcDefinitions.byTable['dbc_spell_duration']!;
    addTearDown(() async {
      if (await dir.exists()) await dir.delete(recursive: true);
    });

    final first = util.export(
      definitions: [definition],
      outputDirectory: dir.path,
      mysqlConfig: mysql,
    );

    final second = await util
        .export(
          definitions: [definition],
          outputDirectory: dir.path,
          mysqlConfig: mysql,
        )
        .toList()
        .timeout(const Duration(seconds: 5));

    expect(
      second.whereType<DbcSyncResult>().single.errors.single.message,
      contains('已有 DBC 任务正在运行'),
    );
    // Release the first task so the test ends cleanly.
    await util.cancel();
    await first.toList().timeout(const Duration(seconds: 5));
  });

  test('DBC 导出：取消请求让 worker 返回取消结果且不生成文件', () async {
    final util = DbcSyncUtil(exportWorkerEntry: _CancelAwareExportWorker.run);
    final dir = await Directory.systemTemp.createTemp('foxy_export_cancel_');
    final definition = DbcDefinitions.byTable['dbc_spell_duration']!;
    addTearDown(() async {
      if (await dir.exists()) await dir.delete(recursive: true);
    });

    final eventsFuture = util
        .export(
          definitions: [definition],
          outputDirectory: dir.path,
          mysqlConfig: mysql,
        )
        .toList();

    // The fake worker only finishes after a cancel message arrives.
    await util.cancel();
    final events = await eventsFuture.timeout(const Duration(seconds: 5));

    final result = events.whereType<DbcSyncResult>().single;
    expect(result.cancelled, isTrue);
    expect(result.completed, 0);
    expect(await File(p.join(dir.path, definition.fileName)).exists(), isFalse);
    expect(util.isRunning, isFalse);
  });

  test(
    'DBC 导入：扩展名大小写不敏感扫描',
    () async {
      final util = DbcSyncUtil();
      final dir = await Directory.systemTemp.createTemp('foxy_import_case_');
      addTearDown(() async {
        if (await dir.exists()) await dir.delete(recursive: true);
      });

      final definition = DbcDefinitions.byTable['dbc_spell_duration']!;
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
      // DB connection only happens after a successful scan; the state must
      // no longer be "no DBC files found".
      expect(text, isNot(contains('未在目录中找到需要的 DBC 文件')));
    },
    skip: Platform.isWindows
        ? 'Windows 文件系统大小写不敏感，无法可靠构造 .DBC 与 .dbc 差异'
        : false,
  );

  test(
    'DBC 导入：同一定义匹配多个文件时报错',
    () async {
      final util = DbcSyncUtil();
      final dir = await Directory.systemTemp.createTemp('foxy_import_dup_');
      addTearDown(() async {
        if (await dir.exists()) await dir.delete(recursive: true);
      });

      final definition = DbcDefinitions.byTable['dbc_spell_duration']!;
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
      expect(result.errors.map((e) => e.message).join('\n'), contains('多个'));
    },
    skip: Platform.isWindows ? 'Windows 文件系统大小写不敏感，无法并存 .dbc 与 .DBC' : false,
  );
}

/// Fake DBC-export worker: registers its control port, then stays alive
/// until a `cancel` message arrives, ending with a cancelled result. Lets
/// the export tests exercise the isolate lifecycle without MySQL.
final class _CancelAwareExportWorker {
  static Future<void> run(DbcExportWorkerArgs args) async {
    final cancelPort = ReceivePort();
    var cancelled = false;
    final subscription = cancelPort.listen((message) {
      if (message == 'cancel') cancelled = true;
    });
    args.sendPort.send(('control', cancelPort.sendPort));
    while (!cancelled) {
      await Future<void>.delayed(const Duration(milliseconds: 20));
    }
    args.sendPort.send(('result', 0, 0, <Map<String, String?>>[], true));
    await subscription.cancel();
    cancelPort.close();
  }
}
