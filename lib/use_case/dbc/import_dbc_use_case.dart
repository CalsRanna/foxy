import 'dart:io';

import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

final class ImportDbcInput {
  final String directory;
  final void Function(DbcSyncProgress progress)? onProgress;

  const ImportDbcInput({required this.directory, this.onProgress});
}

final class ImportDbcUseCase {
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

  Future<DbcSyncResult> execute(ImportDbcInput input) async {
    if (_executing || _dbcSyncUtil.isRunning) {
      throw StateError('已有 DBC 任务正在运行');
    }

    final directory = input.directory.trim();
    if (directory.isEmpty) {
      throw ArgumentError.value(directory, 'directory', '请先选择 DBC 文件目录');
    }
    if (!await Directory(directory).exists()) {
      throw FileSystemException('DBC 目录不存在', directory);
    }

    final cancelGeneration = _cancelGeneration;
    _executing = true;
    try {
      final config = await _configUtil.load();
      if (cancelGeneration != _cancelGeneration) {
        return _cancelledResult;
      }

      await _configUtil.update({'dbc_path': directory});
      if (cancelGeneration != _cancelGeneration) {
        return _cancelledResult;
      }

      final mysqlConfig = MysqlConfig(
        host: config['host']?.toString() ?? '127.0.0.1',
        port: _parsePort(config['port']),
        database: config['database']?.toString() ?? 'acore_world',
        username: config['username']?.toString() ?? 'acore',
        password: config['password']?.toString() ?? 'acore',
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
      return result ?? (throw StateError('DBC 导入任务结束但未返回结果'));
    } finally {
      _executing = false;
    }
  }

  Future<void> cancel() async {
    _cancelGeneration++;
    await _dbcSyncUtil.cancel();
  }

  Future<List<DbcTableCheckResult>> checkTables() {
    return _dbcSyncUtil.checkTables();
  }

  static int _parsePort(Object? value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 3306;
  }

  static const _cancelledResult = DbcSyncResult(
    operation: DbcSyncOperation.import,
    completed: 0,
    skipped: 0,
    errors: [],
    cancelled: true,
  );
}
