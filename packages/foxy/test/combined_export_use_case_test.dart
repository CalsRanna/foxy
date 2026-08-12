import 'dart:io';
import 'dart:isolate';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_registry.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_worker.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/infrastructure/dbc/mpq_export_worker.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/use_case/combined/combined_export_use_case.dart';
import 'package:path/path.dart' as p;

/// End-to-end tests of the combined DBC+MPQ export: a real [DbcSyncUtil]
/// with scripted workers so the temp-dir handoff (DBC phase → copy phase →
/// pack phase) and the final cleanup are exercised without a database.
void main() {
  late Directory tempDir;
  late Directory dbcDir;
  late Directory mpqDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('foxy_combined_');
    dbcDir = Directory(p.join(tempDir.path, 'dbc'))..createSync();
    mpqDir = Directory(p.join(tempDir.path, 'mpq'))..createSync();
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  /// Scripted DBC export worker: writes a real .dbc file into its output
  /// directory (the temp dir), so the copy phase has something to copy and
  /// the pack phase has something to pack.
  Future<void> dbcWorker(DbcExportWorkerArgs args) async {
    final cancelPort = ReceivePort();
    final sub = cancelPort.listen((_) {});
    args.sendPort.send(('control', cancelPort.sendPort));
    args.sendPort.send(('status', 'scanning', 'ok', null));
    await DbcExportUtil().write(
      definition: dbcDefinitionByTable['dbc_spell_duration']!,
      rows: const [
        {'ID': 1, 'Duration': 1, 'DurationPerLevel': 0, 'MaxDuration': 1},
      ],
      outputDirectory: args.outputDirectory,
    );
    args.sendPort.send(('count', 'SpellDuration.dbc', 1, 1, 1, 1));
    args.sendPort.send(('result', 1, 0, <Map<String, String?>>[], false));
    await sub.cancel();
    cancelPort.close();
  }

  /// Scripted pack worker: packs with the real [MpqExportWorker.packDbcFiles] so the
  /// produced archive is verifiable. Throws when the DBC file written by the
  /// DBC phase is missing — a failure here surfaces as a worker error, i.e.
  /// the reuse of the temp dir is asserted through the result.
  Future<void> packWorker(MpqPackWorkerArgs args) async {
    final cancelPort = ReceivePort();
    final sub = cancelPort.listen((_) {});
    args.sendPort.send(('control', cancelPort.sendPort));
    if (!await File(p.join(args.directory, 'SpellDuration.dbc')).exists()) {
      throw StateError('pack input directory missing SpellDuration.dbc');
    }
    final summary = await MpqExportWorker.packDbcFiles(
      directory: args.directory,
      mpqFilePath: args.mpqFilePath,
      isCancelled: () => false,
      onStatus: (stage, message) =>
          args.sendPort.send(('status', stage, message, null)),
      onProgress: (fileName, completedFiles, totalFiles, processed, total) =>
          args.sendPort.send((
            'count',
            fileName,
            completedFiles,
            totalFiles,
            processed,
            total,
          )),
    );
    args.sendPort.send((
      'result',
      summary.completed,
      summary.skipped,
      summary.errors,
      false,
    ));
    await sub.cancel();
    cancelPort.close();
  }

  /// The combined use case with the scripted workers wired in.
  CombinedExportUseCase buildUseCase() {
    final util = DbcSyncUtil(
      exportWorkerEntry: dbcWorker,
      mpqPackWorkerEntry: packWorker,
    );
    return CombinedExportUseCase(
      registry: _FakeRegistry(),
      dbcSyncUtil: util,
      configUtil: _MemoryConfigUtil({}),
    );
  }

  test('一键导出: 临时目录复用、拷贝到 DBC 目录、打包 MPQ、结束后清理临时目录', () async {
    final useCase = buildUseCase();
    final mpqPath = p.join(mpqDir.path, 'patch-zhCN-5.MPQ');

    final result = await useCase.execute(
      CombinedExportInput(
        definitions: [dbcDefinitionByTable['dbc_spell_duration']!],
        dbcOutputDirectory: dbcDir.path,
        mpqFilePath: mpqPath,
      ),
    );

    expect(result.success, isTrue, reason: '${result.errors}');
    expect(result.completed, 1, reason: 'pack 必须打包到 DBC 阶段写出的文件（复用临时目录，不重新读库）');
    expect(
      await File(p.join(dbcDir.path, 'SpellDuration.dbc')).exists(),
      isTrue,
      reason: 'DBC 文件必须已拷贝到目标目录',
    );
    expect(await File(mpqPath).exists(), isTrue, reason: 'MPQ 必须已生成');

    // 导出结束后临时目录必须被删除。
    final leftovers = Directory.systemTemp
        .listSync()
        .whereType<Directory>()
        .where((dir) => dir.path.contains('foxy_dbc_export_'));
    expect(leftovers, isEmpty, reason: '导出结束后临时目录必须删除');
  });

  test('DBC 阶段取消 → 跳过 pack,结果标记取消,临时目录仍清理', () async {
    final util = DbcSyncUtil(
      exportWorkerEntry: (DbcExportWorkerArgs args) async {
        final cancelPort = ReceivePort();
        final sub = cancelPort.listen((_) {});
        args.sendPort.send(('control', cancelPort.sendPort));
        args.sendPort.send(('result', 0, 0, <Map<String, String?>>[], true));
        await sub.cancel();
        cancelPort.close();
      },
      mpqPackWorkerEntry: packWorker,
    );
    final useCase = CombinedExportUseCase(
      registry: _FakeRegistry(),
      dbcSyncUtil: util,
      configUtil: _MemoryConfigUtil({}),
    );

    final result = await useCase.execute(
      CombinedExportInput(
        definitions: [dbcDefinitionByTable['dbc_spell_duration']!],
        dbcOutputDirectory: dbcDir.path,
        mpqFilePath: p.join(mpqDir.path, 'patch-zhCN-5.MPQ'),
      ),
    );

    expect(result.cancelled, isTrue);
    expect(
      await File(p.join(mpqDir.path, 'patch-zhCN-5.MPQ')).exists(),
      isFalse,
      reason: 'DBC 阶段取消后不得继续打包',
    );
    final leftovers = Directory.systemTemp
        .listSync()
        .whereType<Directory>()
        .where((dir) => dir.path.contains('foxy_dbc_export_'));
    expect(leftovers, isEmpty);
  });

  test('DBC 阶段部分失败 → 仍拷贝已写出文件并打包,错误汇总到结果', () async {
    final util = DbcSyncUtil(
      exportWorkerEntry: (DbcExportWorkerArgs args) async {
        final cancelPort = ReceivePort();
        final sub = cancelPort.listen((_) {});
        args.sendPort.send(('control', cancelPort.sendPort));
        await DbcExportUtil().write(
          definition: dbcDefinitionByTable['dbc_spell_duration']!,
          rows: const [
            {'ID': 1, 'Duration': 1, 'DurationPerLevel': 0, 'MaxDuration': 1},
          ],
          outputDirectory: args.outputDirectory,
        );
        args.sendPort.send((
          'result',
          1,
          0,
          [
            {
              'tableName': 'dbc_spell_icon',
              'fileName': 'SpellIcon.dbc',
              'stage': 'writing',
              'message': 'boom',
            },
          ],
          false,
        ));
        await sub.cancel();
        cancelPort.close();
      },
      mpqPackWorkerEntry: packWorker,
    );
    final useCase = CombinedExportUseCase(
      registry: _FakeRegistry(),
      dbcSyncUtil: util,
      configUtil: _MemoryConfigUtil({}),
    );

    final result = await useCase.execute(
      CombinedExportInput(
        definitions: [dbcDefinitionByTable['dbc_spell_duration']!],
        dbcOutputDirectory: dbcDir.path,
        mpqFilePath: p.join(mpqDir.path, 'patch-zhCN-5.MPQ'),
      ),
    );

    expect(result.success, isFalse);
    expect(result.errors, hasLength(1));
    expect(result.errors.single.fileName, 'SpellIcon.dbc');
    expect(
      await File(p.join(mpqDir.path, 'patch-zhCN-5.MPQ')).exists(),
      isTrue,
      reason: '部分失败仍应打包已写出的文件',
    );
    expect(
      await File(p.join(dbcDir.path, 'SpellDuration.dbc')).exists(),
      isTrue,
      reason: '部分失败仍应拷贝已写出的文件',
    );
  });

  test('校验: MPQ 文件名必须 .mpq 结尾', () async {
    final useCase = buildUseCase();
    await expectLater(
      useCase.execute(
        CombinedExportInput(
          definitions: [dbcDefinitionByTable['dbc_spell_duration']!],
          dbcOutputDirectory: dbcDir.path,
          mpqFilePath: p.join(mpqDir.path, 'patch.txt'),
        ),
      ),
      throwsA(isA<ValidationException>()),
    );
  });
}

/// Registry stub: no GetIt resolution, no DB access.
final class _FakeRegistry implements DbcExportRegistry {
  @override
  bool contains(String tableName) => true;

  @override
  Future<DbcExportCountResult> countRows(String tableName) async =>
      const DbcExportCountResult.success(1);

  @override
  Future<List<Map<String, dynamic>>> loadRows(String tableName) async => [
    {'ID': 1},
  ];
}

/// In-memory ConfigUtil (no real IO), mirroring the wizard-test fake.
final class _MemoryConfigUtil extends ConfigUtil {
  final Map<String, dynamic> data;

  _MemoryConfigUtil(this.data);

  @override
  String get configPath => 'memory:config.yaml';

  @override
  Future<Map<String, dynamic>> load() async => Map<String, dynamic>.of(data);

  @override
  Future<void> update(Map<String, dynamic> values) async {
    data.addAll(values);
  }
}
