import 'dart:io';
import 'dart:isolate';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_worker.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/model/dbc/dbc_sync_progress.dart';
import 'package:foxy_game_file/foxy_game_file.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:path/path.dart' as p;

void main() {
  // Two tests below need `.dbc` and `.DBC` side by side, which a
  // case-insensitive volume (Windows; macOS APFS by default) cannot hold, so
  // they are skipped unless the temp filesystem really distinguishes case.
  final caseSensitiveFs = _isCaseSensitiveFileSystem();

  const mysql = MysqlConfig(
    database: 'unused',
    username: 'unused',
    password: 'unused',
    useSsl: false,
  );

  test('DBC import emits one failure and closes the stream when the directory is missing', () async {
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

  test('DBC import returns an error while another import is running', () async {
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

  test('DBC export succeeds immediately with no definitions', () async {
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

  test(
    'DBC export warns when row order is missing and still succeeds',
    () async {
      final util = DbcSyncUtil(exportWorkerEntry: _WarningExportWorker.run);
      final events = await util
          .export(
            definitions: [DbcDefinitions.byTable['dbc_talent']!],
            outputDirectory: Directory.systemTemp.path,
            mysqlConfig: mysql,
          )
          .toList()
          .timeout(const Duration(seconds: 5));

      final result = events.whereType<DbcSyncResult>().single;
      expect(result.success, isTrue);
      expect(result.completed, 1);
      expect(result.warnings, hasLength(1));
      expect(result.warnings.single.message, contains('重新导入'));
      expect(util.isRunning, isFalse);
    },
  );

  test('DBC export prevents concurrent runs', () async {
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

  test(
    'DBC export cancellation returns a canceled result without creating files',
    () async {
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
      expect(
        await File(p.join(dir.path, definition.fileName)).exists(),
        isFalse,
      );
      expect(util.isRunning, isFalse);
    },
  );

  test('DBC import matches file extensions case-insensitively', () async {
    final util = DbcSyncUtil();
    final dir = await Directory.systemTemp.createTemp('foxy_import_case_');
    addTearDown(() async {
      if (await dir.exists()) await dir.delete(recursive: true);
    });

    final definition = DbcDefinitions.byTable['dbc_spell_duration']!;
    await DbcFileWriter().write(
      schema: definition.schema,
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
  }, skip: caseSensitiveFs ? false : '文件系统大小写不敏感，无法可靠构造 .DBC 与 .dbc 差异');

  test(
    'DBC import reports multiple files matching the same definition',
    () async {
      final util = DbcSyncUtil();
      final dir = await Directory.systemTemp.createTemp('foxy_import_dup_');
      addTearDown(() async {
        if (await dir.exists()) await dir.delete(recursive: true);
      });

      final definition = DbcDefinitions.byTable['dbc_spell_duration']!;
      await DbcFileWriter().write(
        schema: definition.schema,
        rows: [
          {'ID': 1, 'Duration': 1, 'DurationPerLevel': 0, 'MaxDuration': 1},
        ],
        outputDirectory: dir.path,
      );
      await File(p.join(dir.path, definition.fileName))
          .copy(p.join(dir.path, 'SpellDuration.DBC'));

      final events = await util
          .import(directory: dir.path, mysqlConfig: mysql)
          .toList()
          .timeout(const Duration(seconds: 15));

      final result = events.whereType<DbcSyncResult>().single;
      expect(result.success, isFalse);
      expect(
        result.errors.map((e) => e.message).join('\n'),
        contains('multiple files match'),
      );
    },
    skip: caseSensitiveFs ? false : '文件系统大小写不敏感，无法并存 .dbc 与 .DBC',
  );
}

/// Whether the temp filesystem distinguishes file names by case.
///
/// The `.dbc`/`.DBC` tests above are only meaningful where writing
/// `X.DBC` next to `x.dbc` yields two files; on Windows and on macOS APFS the
/// second write lands on the first one instead.
bool _isCaseSensitiveFileSystem() {
  final probeDir = Directory.systemTemp.createTempSync('foxy_case_probe_');
  try {
    File(p.join(probeDir.path, 'probe.dbc')).writeAsStringSync('');
    return !File(p.join(probeDir.path, 'PROBE.DBC')).existsSync();
  } finally {
    probeDir.deleteSync(recursive: true);
  }
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

/// Fake DBC-export worker emitting a row-order warning before its result,
/// mirroring the real worker's `('warning', tableNames)` message. Lets the
/// export tests verify warning propagation without MySQL.
final class _WarningExportWorker {
  static Future<void> run(DbcExportWorkerArgs args) async {
    final cancelPort = ReceivePort();
    final subscription = cancelPort.listen((_) {});
    args.sendPort.send(('control', cancelPort.sendPort));
    args.sendPort.send(('warning', ['Talent.dbc']));
    args.sendPort.send(('result', 1, 0, <Map<String, String?>>[], false));
    await subscription.cancel();
    cancelPort.close();
  }
}
