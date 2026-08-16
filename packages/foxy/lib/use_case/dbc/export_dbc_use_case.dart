import 'dart:io';

import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_registry.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/use_case/dbc/dbc_export_shared.dart';

final class DbcExportTable {
  final DbcDefinition definition;
  final int? recordCount;
  final Object? countError;

  const DbcExportTable({
    required this.definition,
    this.recordCount,
    this.countError,
  });
}

final class ExportDbcInput {
  final List<DbcDefinition> definitions;
  final String outputDirectory;
  final void Function(DbcSyncProgress progress)? onProgress;

  const ExportDbcInput({
    required this.definitions,
    required this.outputDirectory,
    this.onProgress,
  });
}

final class ExportDbcUseCase {
  final DbcExportRegistry _registry;
  final DbcSyncUtil _dbcSyncUtil;
  final ConfigUtil _configUtil;

  ExportDbcUseCase({
    required DbcExportRegistry registry,
    required DbcSyncUtil dbcSyncUtil,
    required ConfigUtil configUtil,
  }) : _registry = registry,
       _dbcSyncUtil = dbcSyncUtil,
       _configUtil = configUtil;

  bool get isRunning => _dbcSyncUtil.isRunning;

  Future<void> cancel() => _dbcSyncUtil.cancel();

  Future<DbcSyncResult> execute(ExportDbcInput input) async {
    final outputDirectory = input.outputDirectory.trim();
    if (outputDirectory.isEmpty) {
      throw ArgumentError.value(
        outputDirectory,
        'outputDirectory',
        'select the DBC output directory first',
      );
    }
    if (input.definitions.isEmpty) {
      throw ValidationException('select at least one DBC table to export');
    }
    if (_dbcSyncUtil.isRunning) {
      throw BusyException('another DBC task is already running');
    }
    await DbcExportUtil.ensureWritableDirectory(outputDirectory);

    final mysqlConfig = await DbcExportShared.mysqlConfigFromSaved(_configUtil);

    // Files are written into a temp directory first, then copied over:
    // nothing lands in the target before it is fully written, and the same
    // temp output is what a combined DBC+MPQ export reuses.
    final tempDir = await Directory.systemTemp.createTemp('foxy_dbc_export_');
    try {
      DbcSyncResult? result;
      await for (final progress in _dbcSyncUtil.export(
        definitions: List.unmodifiable(input.definitions),
        outputDirectory: tempDir.path,
        mysqlConfig: mysqlConfig,
      )) {
        input.onProgress?.call(progress);
        if (progress case DbcSyncResult()) {
          result = progress;
        }
      }

      final workerResult =
          result ??
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
        targetDirectory: outputDirectory,
      );
      return DbcSyncResult(
        operation: DbcSyncOperation.export,
        completed: workerResult.completed,
        skipped: workerResult.skipped,
        errors: [...workerResult.errors, ...copyErrors],
        cancelled: workerResult.cancelled,
      );
    } finally {
      try {
        await tempDir.delete(recursive: true);
      } catch (_) {
        // A failed temp cleanup must not fail the export.
      }
    }
  }

  Future<List<DbcExportTable>> loadTables() =>
      DbcExportShared.loadDbcExportTables(_registry);
}
