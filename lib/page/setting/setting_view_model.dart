import 'dart:async';

import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_registry.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:signals/signals.dart';

class DbcExportItem {
  final DbcDefinition definition;
  final int? recordCount;
  final String? countError;
  final bool selected;

  const DbcExportItem({
    required this.definition,
    this.recordCount,
    this.countError,
    this.selected = true,
  });

  String get tableName => definition.tableName;
  String get dbcFileName => definition.fileName;
  bool get countFailed => countError != null;
  bool get canSelect => !countFailed;

  /// 列表展示用的行数文案：区分空表与计数失败。
  String get recordCountLabel {
    if (countFailed) return '计数失败';
    final count = recordCount ?? 0;
    if (count == 0) return '空表';
    return '$count 条';
  }

  DbcExportItem copyWith({bool? selected}) {
    return DbcExportItem(
      definition: definition,
      recordCount: recordCount,
      countError: countError,
      selected: selected ?? this.selected,
    );
  }
}

class SettingViewModel {
  final _configUtil = GetIt.instance.get<ConfigUtil>();
  final _dbcSync = GetIt.instance.get<DbcSyncUtil>();
  final _dbcExportRegistry = GetIt.instance.get<DbcExportRegistry>();

  // ========== 导出 ==========

  final dbcExportItems = signal<List<DbcExportItem>>([]);
  final dbcExporting = signal(false);
  final dbcExportProgress = signal<double?>(null);
  final dbcExportProgressLabel = signal('');
  final dbcExportProgressDetail = signal('');
  final dbcExportError = signal<String?>(null);
  final dbcExportSuccess = signal(false);
  final dbcExportSuccessMessage = signal('');

  // ========== 导入 ==========

  final dbcImportPath = signal<String?>(null);
  final dbcImporting = signal(false);
  final dbcImportCancelling = signal(false);
  final dbcImportProgress = signal<double?>(null);
  final dbcImportProgressLabel = signal('');
  final dbcImportProgressDetail = signal('');
  final dbcImportError = signal<String?>(null);
  final dbcImportSuccess = signal(false);
  final dbcImportSuccessMessage = signal('');

  /// 每次 startImport 递增；取消/过期 attempt 用 token 判定，避免旧任务复活。
  int _importAttemptId = 0;

  List<DbcExportItem> get selectableItems =>
      dbcExportItems.value.where((item) => item.canSelect).toList();

  List<DbcExportItem> get selectedExportableItems => dbcExportItems.value
      .where((item) => item.selected && item.canSelect)
      .toList();

  int get countFailureCount =>
      dbcExportItems.value.where((item) => item.countFailed).length;

  bool get allSelectableSelected {
    final selectable = selectableItems;
    if (selectable.isEmpty) return false;
    return selectable.every((item) => item.selected);
  }

  bool get isDbcBusy =>
      dbcExporting.value || dbcImporting.value || _dbcSync.isRunning;

  // ---------- 导出 ----------

  /// 打开导出对话框时：清空反馈，并返回配置中的默认输出目录（dbc_path）。
  Future<String?> prepareExportDialog() async {
    clearExportFeedback();
    final config = await _configUtil.load();
    final path = config['dbc_path']?.toString().trim();
    if (path == null || path.isEmpty) return null;
    return path;
  }

  Future<void> loadExportItems() async {
    final items = <DbcExportItem>[];
    for (final definition in dbcDefinitions) {
      final countResult = await _dbcExportRegistry.countRows(
        definition.tableName,
      );
      if (!countResult.success) {
        LoggerUtil.instance.w(
          '计算 ${definition.tableName} 行数失败: ${countResult.error}',
        );
        items.add(
          DbcExportItem(
            definition: definition,
            countError: countResult.error.toString(),
            selected: false,
          ),
        );
        continue;
      }
      items.add(
        DbcExportItem(
          definition: definition,
          recordCount: countResult.count ?? 0,
        ),
      );
    }
    items.sort((left, right) => left.dbcFileName.compareTo(right.dbcFileName));
    dbcExportItems.value = items;
  }

  void setItemSelected(String tableName, bool selected) {
    final items = [...dbcExportItems.value];
    final index = items.indexWhere((item) => item.tableName == tableName);
    if (index == -1) return;
    final item = items[index];
    if (item.countFailed) return;
    items[index] = item.copyWith(selected: selected);
    dbcExportItems.value = items;
  }

  void setAllSelectableSelected(bool selected) {
    dbcExportItems.value = [
      for (final item in dbcExportItems.value)
        if (item.countFailed)
          item.copyWith(selected: false)
        else
          item.copyWith(selected: selected),
    ];
  }

  void clearExportFeedback() {
    dbcExportError.value = null;
    dbcExportSuccess.value = false;
    dbcExportSuccessMessage.value = '';
  }

  Future<bool> exportDbc(String outputDirectory) {
    return _startExport(outputDirectory);
  }

  Future<bool> retryExport(String outputDirectory) {
    return _startExport(outputDirectory);
  }

  Future<bool> _startExport(String outputDirectory) async {
    final invalidSelected = dbcExportItems.value
        .where((item) => item.selected && item.countFailed)
        .toList();
    if (invalidSelected.isNotEmpty) {
      dbcExportError.value =
          '以下表行数统计失败，无法导出：\n'
          '${invalidSelected.map((item) => item.dbcFileName).join('\n')}';
      return false;
    }

    final selected = selectedExportableItems;
    if (selected.isEmpty || dbcExporting.value || _dbcSync.isRunning) {
      return false;
    }

    dbcExporting.value = true;
    dbcExportProgress.value = 0;
    dbcExportProgressLabel.value = '准备导出...';
    dbcExportProgressDetail.value = '';
    dbcExportError.value = null;
    dbcExportSuccess.value = false;
    dbcExportSuccessMessage.value = '';

    try {
      DbcSyncResult? result;
      final stream = _dbcSync.export(
        definitions: selected.map((item) => item.definition).toList(),
        outputDirectory: outputDirectory,
        loadRows: _dbcExportRegistry.loadRows,
      );

      await for (final progress in stream) {
        switch (progress) {
          case DbcSyncStatus(:final message):
            dbcExportProgressLabel.value = message;
          case DbcSyncCount(
            :final fileName,
            :final completedFiles,
            :final totalFiles,
            :final processedRows,
          ):
            dbcExportProgress.value = totalFiles > 0
                ? completedFiles / totalFiles
                : null;
            dbcExportProgressLabel.value = fileName;
            final rowText = processedRows > 0 ? '，$processedRows 行' : '';
            dbcExportProgressDetail.value =
                '已处理 $completedFiles / $totalFiles 个文件$rowText';
          case DbcSyncResult():
            result = progress;
        }
      }

      if (result == null) {
        throw StateError('DBC 导出任务结束但未返回结果');
      }

      if (result.success) {
        final message =
            '成功导出 ${result.completed} 个文件'
            '${result.skipped > 0 ? '，跳过 ${result.skipped} 个空表' : ''}。';
        LoggerUtil.instance.i('DBC 导出完成: $message');
        dbcExportSuccessMessage.value = message;
        dbcExportSuccess.value = true;
        return true;
      }

      final top = result.errors.take(5).join('\n');
      dbcExportError.value =
          '导出结束，部分文件失败（成功 ${result.completed}，跳过 ${result.skipped}）：\n$top'
          '${result.errors.length > 5 ? '\n...等 ${result.errors.length} 个错误' : ''}';
      return false;
    } catch (error) {
      LoggerUtil.instance.e('DBC 导出异常: $error');
      dbcExportError.value = '导出出错：$error';
      return false;
    } finally {
      dbcExporting.value = false;
      dbcExportProgress.value = null;
      dbcExportProgressLabel.value = '';
      dbcExportProgressDetail.value = '';
    }
  }

  // ---------- 导入 ----------

  Future<void> prepareImportDialog() async {
    clearImportFeedback();
    final config = await _configUtil.load();
    final path = config['dbc_path']?.toString();
    if (path != null && path.isNotEmpty) {
      dbcImportPath.value = path;
    }
  }

  void clearImportFeedback() {
    dbcImportError.value = null;
    dbcImportSuccess.value = false;
    dbcImportSuccessMessage.value = '';
  }

  Future<void> setImportPath(String path) async {
    final trimmed = path.trim();
    if (trimmed.isEmpty) {
      dbcImportPath.value = null;
      return;
    }
    try {
      dbcImportPath.value = trimmed;
      clearImportFeedback();
      await _configUtil.update({'dbc_path': trimmed});
    } catch (error) {
      LoggerUtil.instance.e('设置 DBC 路径失败: $error');
      dbcImportError.value = '设置路径失败：$error';
    }
  }

  /// 仅更新内存路径（输入框 onChanged），不立即写盘。
  void setImportPathLocal(String path) {
    final trimmed = path.trim();
    dbcImportPath.value = trimmed.isEmpty ? null : trimmed;
  }

  Future<void> startImport() async {
    final path = dbcImportPath.value?.trim();
    if (path == null || path.isEmpty) {
      dbcImportError.value = '请先选择 DBC 文件目录。';
      return;
    }
    if (dbcImporting.value || _dbcSync.isRunning) return;
    // 先占坑，防止 await 配置写入期间双击穿透。
    final attemptId = ++_importAttemptId;
    dbcImporting.value = true;
    dbcImportCancelling.value = false;
    dbcImportProgress.value = 0;
    dbcImportProgressLabel.value = '准备导入...';
    dbcImportProgressDetail.value = '';
    dbcImportError.value = null;
    dbcImportSuccess.value = false;
    dbcImportSuccessMessage.value = '';
    try {
      await setImportPath(path);
      if (!_isCurrentImportAttempt(attemptId)) return;
      if (dbcImportError.value != null) {
        _resetImportProgress();
        return;
      }
      if (_dbcSync.isRunning) {
        _resetImportProgress();
        dbcImportError.value = '已有 DBC 任务正在运行';
        return;
      }
      unawaited(_runImport(path, attemptId: attemptId));
    } catch (error) {
      if (!_isCurrentImportAttempt(attemptId)) return;
      _resetImportProgress();
      dbcImportError.value = '导入出错：$error';
    }
  }

  Future<void> retryImport() async {
    if (dbcImporting.value || _dbcSync.isRunning) return;
    clearImportFeedback();
    await startImport();
  }

  Future<void> cancelImport() async {
    if (!dbcImporting.value || dbcImportCancelling.value) return;
    dbcImportCancelling.value = true;
    if (_dbcSync.isRunning) {
      // worker 已启动：由 DbcSyncUtil 终态回调收尾，勿递增 attempt（否则结果被丢弃）。
      await _dbcSync.cancel();
    } else {
      // 准备阶段：使当前 attempt 失效，旧的 await 恢复后不会再启动 worker。
      _importAttemptId++;
      _resetImportProgress();
      dbcImportError.value = '导入已取消';
    }
  }

  bool _isCurrentImportAttempt(int attemptId) => attemptId == _importAttemptId;

  Future<void> _runImport(String directory, {required int attemptId}) async {
    if (!_isCurrentImportAttempt(attemptId)) return;
    try {
      final config = await _configUtil.load();
      final mysqlConfig = MysqlConfig(
        host: config['host']?.toString() ?? '127.0.0.1',
        port: _parsePort(config['port']),
        database: config['database']?.toString() ?? 'acore_world',
        username: config['username']?.toString() ?? 'acore',
        password: config['password']?.toString() ?? 'acore',
      );
      if (!_isCurrentImportAttempt(attemptId)) return;
      final stream = _dbcSync.import(
        directory: directory,
        mysqlConfig: mysqlConfig,
      );

      DbcSyncResult? result;
      await for (final progress in stream) {
        switch (progress) {
          case DbcSyncStatus(:final message):
            dbcImportProgressLabel.value = message;
          case DbcSyncCount(
            :final fileName,
            :final completedFiles,
            :final totalFiles,
            :final processedRows,
            :final totalRows,
          ):
            dbcImportProgress.value = totalFiles > 0
                ? completedFiles / totalFiles
                : null;
            dbcImportProgressLabel.value = fileName;
            final rowText = totalRows == null
                ? ''
                : '，当前文件 $processedRows / $totalRows 行';
            dbcImportProgressDetail.value =
                '已处理 $completedFiles / $totalFiles 个文件$rowText';
          case DbcSyncResult():
            result = progress;
        }
      }

      if (!_isCurrentImportAttempt(attemptId)) return;
      if (result == null) {
        throw StateError('DBC 导入任务结束但未返回结果');
      }
      await _handleImportResult(result);
    } catch (error) {
      if (!_isCurrentImportAttempt(attemptId)) return;
      _resetImportProgress();
      dbcImportError.value = '导入出错：$error';
      LoggerUtil.instance.e('DBC 导入异常: $error');
    }
  }

  Future<void> _handleImportResult(DbcSyncResult result) async {
    if (result.cancelled) {
      _resetImportProgress();
      dbcImportError.value = '导入已取消';
      return;
    }

    if (result.success) {
      final message =
          '导入完成：写入 ${result.completed} 个文件'
          '${result.skipped > 0 ? '，跳过 ${result.skipped} 个' : ''}。';
      LoggerUtil.instance.i(message);
      dbcImportSuccessMessage.value = message;
      dbcImportSuccess.value = true;
      _resetImportProgress();
      return;
    }

    _resetImportProgress();
    final top = result.errors.take(5).join('\n');
    dbcImportError.value =
        '导入结束，部分文件失败（成功 ${result.completed}，跳过 ${result.skipped}）：\n$top'
        '${result.errors.length > 5 ? '\n...等 ${result.errors.length} 个错误' : ''}';
  }

  void _resetImportProgress() {
    dbcImporting.value = false;
    dbcImportCancelling.value = false;
    dbcImportProgress.value = null;
    dbcImportProgressLabel.value = '';
    dbcImportProgressDetail.value = '';
  }

  static int _parsePort(Object? value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 3306;
  }
}
