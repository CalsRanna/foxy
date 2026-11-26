import 'dart:io';

import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/database/saved_mysql_config.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/model/dbc/dbc_sync_progress.dart';

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

  ImportDbcUseCase({required this._configUtil, required this._dbcSyncUtil});

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

      final mysqlConfig = SavedMysqlConfig.fromMap(config);

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
}
