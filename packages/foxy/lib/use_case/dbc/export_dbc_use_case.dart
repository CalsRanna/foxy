import 'dart:io';

import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_registry.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

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

    final mysqlConfig = await mysqlConfigFromSaved(_configUtil);

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

  Future<List<DbcExportTable>> loadTables() => loadDbcExportTables(_registry);
}

/// Loads the row-count view of every DBC table for the export-selection
/// dialog. Shared by the standalone and combined export use cases.
Future<List<DbcExportTable>> loadDbcExportTables(
  DbcExportRegistry registry,
) async {
  final tables = <DbcExportTable>[];
  for (final definition in DbcDefinitions.all) {
    final result = await registry.countRows(definition.tableName);
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

/// Builds the MySQL config from the saved config.yaml (same defaults as the
/// bootstrap wizard). Shared by the standalone and combined export use cases.
Future<MysqlConfig> mysqlConfigFromSaved(ConfigUtil configUtil) async {
  final config = await configUtil.load();
  return MysqlConfig(
    host: config['host']?.toString() ?? '127.0.0.1',
    port: parseMysqlPort(config['port']),
    database: config['database']?.toString() ?? 'acore_world',
    username: config['username']?.toString() ?? 'acore',
    password: config['password']?.toString() ?? 'acore',
    useSsl: config['use_ssl'] == true,
    allowPublicKeyRetrieval: config['use_ssl'] != true,
  );
}

int parseMysqlPort(Object? value) {
  if (value is int) return value;
  return int.tryParse(value?.toString() ?? '') ?? 3306;
}
