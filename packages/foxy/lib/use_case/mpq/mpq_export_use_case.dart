import 'dart:io';

import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_registry.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/use_case/dbc/export_dbc_use_case.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:path/path.dart' as p;

final class MpqExportInput {
  final List<DbcDefinition> definitions;
  final String mpqFilePath;
  final void Function(DbcSyncProgress progress)? onProgress;

  const MpqExportInput({
    required this.definitions,
    required this.mpqFilePath,
    this.onProgress,
  });
}

/// Exports selected DBC tables as a WoW patch MPQ (default file name
/// `patch-zhCN-5.mpq`) into the client's MPQ directory.
///
/// Table statistics for the picker come from [loadTables]; the actual work
/// runs on a dedicated isolate via [DbcSyncUtil.exportMpq], with the MySQL
/// connection parameters read from config.
class MpqExportUseCase {
  late final DbcExportRegistry _registry;
  late final DbcSyncUtil _dbcSyncUtil;
  late final ConfigUtil _configUtil;

  MpqExportUseCase({
    required DbcExportRegistry registry,
    required DbcSyncUtil dbcSyncUtil,
    required ConfigUtil configUtil,
  }) : _registry = registry,
       _dbcSyncUtil = dbcSyncUtil,
       _configUtil = configUtil;

  /// For test subclasses that stub [execute]/[loadTables] and never touch
  /// the injected fields (late-final fields stay uninitialized until read).
  MpqExportUseCase.protected();

  bool get isRunning => _dbcSyncUtil.isRunning;

  Future<void> cancel() => _dbcSyncUtil.cancel();

  Future<DbcSyncResult> execute(MpqExportInput input) async {
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
    final outputDirectory = p.dirname(mpqFilePath);
    if (outputDirectory.isEmpty || !await Directory(outputDirectory).exists()) {
      throw ValidationException('the MPQ output directory does not exist');
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
    await for (final progress in _dbcSyncUtil.exportMpq(
      definitions: List.unmodifiable(input.definitions),
      mpqFilePath: mpqFilePath,
      mysqlConfig: mysqlConfig,
    )) {
      input.onProgress?.call(progress);
      if (progress case DbcSyncResult()) {
        result = progress;
      }
    }
    return result ??
        (throw StateError('MPQ export task ended without a result'));
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
