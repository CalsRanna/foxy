import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_registry.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';

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

  Future<DbcSyncResult> execute(ExportDbcInput input) async {
    final outputDirectory = input.outputDirectory.trim();
    if (outputDirectory.isEmpty) {
      throw ArgumentError.value(
        outputDirectory,
        'outputDirectory',
        '请先选择 DBC 输出目录',
      );
    }
    if (input.definitions.isEmpty) {
      throw StateError('请至少选择一张可导出的 DBC 表');
    }
    if (_dbcSyncUtil.isRunning) {
      throw StateError('已有 DBC 任务正在运行');
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
    return result ?? (throw StateError('DBC 导出任务结束但未返回结果'));
  }
}
