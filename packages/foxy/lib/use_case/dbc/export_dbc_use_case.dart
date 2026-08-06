import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_registry.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';

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

  ExportDbcUseCase({
    required DbcExportRegistry registry,
    required DbcSyncUtil dbcSyncUtil,
  }) : _registry = registry,
       _dbcSyncUtil = dbcSyncUtil;

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

    DbcSyncResult? result;
    await for (final progress in _dbcSyncUtil.export(
      definitions: List.unmodifiable(input.definitions),
      outputDirectory: outputDirectory,
      loadRows: _registry.loadRows,
    )) {
      input.onProgress?.call(progress);
      if (progress case DbcSyncResult()) {
        result = progress;
      }
    }
    return result ??
        (throw StateError('DBC export task ended without a result'));
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
}
