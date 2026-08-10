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

    DbcSyncResult? result;
    await for (final progress in _dbcSyncUtil.export(
      definitions: List.unmodifiable(input.definitions),
      outputDirectory: outputDirectory,
      mysqlConfig: mysqlConfig,
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
    for (final definition in DbcDefinitions.all) {
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
