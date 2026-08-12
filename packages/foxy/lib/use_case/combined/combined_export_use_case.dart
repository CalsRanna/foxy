import 'dart:io';

import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_registry.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/use_case/dbc/export_dbc_use_case.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:path/path.dart' as p;

final class CombinedExportInput {
  final List<DbcDefinition> definitions;
  final String dbcOutputDirectory;
  final String mpqFilePath;
  final void Function(DbcSyncProgress progress)? onProgress;

  const CombinedExportInput({
    required this.definitions,
    required this.dbcOutputDirectory,
    required this.mpqFilePath,
    this.onProgress,
  });
}

/// One-click DBC + MPQ export: writes the selected tables once into a shared
/// temp directory, copies the `.dbc` files over to the DBC target directory,
/// then packs the very same files into the MPQ patch — no second database
/// read. The temp directory is deleted once every export path finishes.
///
/// Cancellation is honored in every phase: the worker phases cancel through
/// [DbcSyncUtil.cancel], the copy phase through a local flag; a cancelled run
/// still copies what was already written (same as the standalone DBC export)
/// but skips the MPQ pack.
class CombinedExportUseCase {
  late final DbcExportRegistry _registry;
  late final DbcSyncUtil _dbcSyncUtil;
  late final ConfigUtil _configUtil;
  var _cancelRequested = false;

  CombinedExportUseCase({
    required DbcExportRegistry registry,
    required DbcSyncUtil dbcSyncUtil,
    required ConfigUtil configUtil,
  }) : _registry = registry,
       _dbcSyncUtil = dbcSyncUtil,
       _configUtil = configUtil;

  /// For test subclasses that stub [execute]/[loadTables] and never touch
  /// the injected fields (late-final fields stay uninitialized until read).
  CombinedExportUseCase.protected();

  bool get isRunning => _dbcSyncUtil.isRunning;

  Future<void> cancel() async {
    _cancelRequested = true;
    await _dbcSyncUtil.cancel();
  }

  Future<DbcSyncResult> execute(CombinedExportInput input) async {
    _cancelRequested = false;
    final dbcOutputDirectory = input.dbcOutputDirectory.trim();
    if (dbcOutputDirectory.isEmpty) {
      throw ArgumentError.value(
        dbcOutputDirectory,
        'dbcOutputDirectory',
        'select the DBC output directory first',
      );
    }
    final mpqFilePath = input.mpqFilePath.trim();
    if (mpqFilePath.isEmpty) {
      throw ArgumentError.value(
        mpqFilePath,
        'mpqFilePath',
        'select the MPQ output path first',
      );
    }
    if (!mpqFilePath.toLowerCase().endsWith('.mpq')) {
      throw ValidationException('the MPQ file name must end with .mpq');
    }
    final mpqDirectory = p.dirname(mpqFilePath);
    if (mpqDirectory.isEmpty || !await Directory(mpqDirectory).exists()) {
      throw ValidationException('the MPQ output directory does not exist');
    }
    if (input.definitions.isEmpty) {
      throw ValidationException('select at least one DBC table to export');
    }
    if (_dbcSyncUtil.isRunning) {
      throw BusyException('another DBC task is already running');
    }
    await DbcExportUtil.ensureWritableDirectory(dbcOutputDirectory);
    await DbcExportUtil.ensureWritableDirectory(mpqDirectory);

    final config = await _configUtil.load();
    final mysqlConfig = MysqlConfig(
      host: config['host']?.toString() ?? '127.0.0.1',
      port: _parsePort(config['port']),
      database: config['database']?.toString() ?? 'acore_world',
      username: config['username']?.toString() ?? 'acore',
      password: config['password']?.toString() ?? 'acore',
      useSsl: config['use_ssl'] == true,
      allowPublicKeyRetrieval: config['use_ssl'] != true,
    );

    final tempDir = await Directory.systemTemp.createTemp('foxy_dbc_export_');
    try {
      DbcSyncResult? dbcResult;
      await for (final progress in _dbcSyncUtil.export(
        definitions: List.unmodifiable(input.definitions),
        outputDirectory: tempDir.path,
        mysqlConfig: mysqlConfig,
      )) {
        input.onProgress?.call(progress);
        if (progress case DbcSyncResult()) {
          dbcResult = progress;
        }
      }
      final workerResult =
          dbcResult ??
          (throw StateError('DBC export task ended without a result'));

      input.onProgress?.call(
        DbcSyncStatus(
          operation: DbcSyncOperation.export,
          stage: DbcSyncStage.committing,
          message: '正在拷贝到 DBC 目录...',
        ),
      );
      final copyErrors = await DbcExportUtil.copyDbcFiles(
        sourceDirectory: tempDir.path,
        targetDirectory: dbcOutputDirectory,
        isCancelled: () => _cancelRequested,
      );

      DbcSyncResult? packResult;
      if (!_cancelRequested && !workerResult.cancelled) {
        await for (final progress in _dbcSyncUtil.exportMpqFromDirectory(
          directory: tempDir.path,
          mpqFilePath: mpqFilePath,
        )) {
          input.onProgress?.call(progress);
          if (progress case DbcSyncResult()) {
            packResult = progress;
          }
        }
      }

      return DbcSyncResult(
        operation: DbcSyncOperation.export,
        completed: packResult?.completed ?? workerResult.completed,
        skipped: packResult?.skipped ?? workerResult.skipped,
        errors: [...workerResult.errors, ...copyErrors, ...?packResult?.errors],
        cancelled:
            _cancelRequested ||
            workerResult.cancelled ||
            (packResult?.cancelled ?? false),
      );
    } finally {
      _cancelRequested = false;
      try {
        await tempDir.delete(recursive: true);
      } catch (_) {
        // A failed temp cleanup must not fail the export.
      }
    }
  }

  Future<List<DbcExportTable>> loadTables() async {
    final tables = <DbcExportTable>[];
    for (final definition in dbcDefinitions) {
      final result = await _registry.countRows(definition.tableName);
      tables.add(
        DbcExportTable(
          definition: definition,
          recordCount: result.count,
          countError: result.error,
        ),
      );
    }
    tables.sort(
      (left, right) =>
          left.definition.fileName.compareTo(right.definition.fileName),
    );
    return tables;
  }

  static int _parsePort(Object? value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 3306;
  }
}
