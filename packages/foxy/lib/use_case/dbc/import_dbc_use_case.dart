import 'dart:io';

import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

final class ImportDbcInput {
  final String directory;
  final void Function(DbcSyncProgress progress)? onProgress;

  const ImportDbcInput({required this.directory, this.onProgress});
}

final class ImportDbcUseCase {
  static const _cancelledResult = DbcSyncResult(
    operation: DbcSyncOperation.import,
    completed: 0,
    skipped: 0,
    errors: [],
    cancelled: true,
  );
  final ConfigUtil _configUtil;

  final DbcSyncUtil _dbcSyncUtil;
  var _cancelGeneration = 0;

  var _executing = false;

  ImportDbcUseCase({
    required ConfigUtil configUtil,
    required DbcSyncUtil dbcSyncUtil,
  }) : _configUtil = configUtil,
       _dbcSyncUtil = dbcSyncUtil;

  bool get isRunning => _executing || _dbcSyncUtil.isRunning;

  Future<void> cancel() async {
    _cancelGeneration++;
    await _dbcSyncUtil.cancel();
  }

  Future<List<DbcTableCheckResult>> checkTables() {
    return _dbcSyncUtil.checkTables();
  }

  Future<DbcSyncResult> execute(ImportDbcInput input) async {
    if (_executing || _dbcSyncUtil.isRunning) {
      throw BusyException('another DBC task is already running');
    }

    final directory = input.directory.trim();
    if (directory.isEmpty) {
      throw ArgumentError.value(
        directory,
        'directory',
        'select the DBC file directory first',
      );
    }
    if (!await Directory(directory).exists()) {
      throw FileSystemException('DBC directory does not exist', directory);
    }

    final cancelGeneration = _cancelGeneration;
    _executing = true;
    try {
      final config = await _configUtil.load();
      if (cancelGeneration != _cancelGeneration) {
        return _cancelledResult;
      }

      await _configUtil.update({'dbc_dir': directory});
      if (cancelGeneration != _cancelGeneration) {
        return _cancelledResult;
      }

      final mysqlConfig = MysqlConfig(
        host: config['host']?.toString() ?? '127.0.0.1',
        port: _parsePort(config['port']),
        database: config['database']?.toString() ?? 'acore_world',
        username: config['username']?.toString() ?? 'acore',
        password: config['password']?.toString() ?? 'acore',
        // The TLS switch follows the saved config (`use_ssl: true` opt-in);
        // off by default. Non-TLS needs RSA public-key retrieval for MySQL
        // 8's caching_sha2_password (laconic_mysql 3.2.0 disables it by
        // default).
        useSsl: config['use_ssl'] == true,
        allowPublicKeyRetrieval: config['use_ssl'] != true,
      );

      DbcSyncResult? result;
      await for (final progress in _dbcSyncUtil.import(
        directory: directory,
        mysqlConfig: mysqlConfig,
      )) {
        input.onProgress?.call(progress);
        if (progress case DbcSyncResult()) {
          result = progress;
        }
      }
      return result ??
          (throw StateError('DBC import task ended without a result'));
    } finally {
      _executing = false;
    }
  }

  static int _parsePort(Object? value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 3306;
  }
}
