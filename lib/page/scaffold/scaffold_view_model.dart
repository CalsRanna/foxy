import 'dart:async';

import 'package:foxy/entity/feature_entity.dart';
import 'package:foxy/repository/feature_repository.dart';
import 'package:foxy/util/config_util.dart';
import 'package:foxy/util/dbc_sync_progress.dart';
import 'package:foxy/util/dbc_sync_util.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:signals/signals.dart';

class ScaffoldViewModel {
  final _featureRepository = GetIt.instance.get<FeatureRepository>();
  final _configUtil = GetIt.instance.get<ConfigUtil>();
  final _dbcSync = GetIt.instance.get<DbcSyncUtil>();

  // ========== 功能模块 ==========

  final allFeatures = signal<List<FeatureEntity>>([]);

  late final pinnedFeatures = computed(
    () => allFeatures.value.where((feature) => feature.isPinned).toList(),
  );

  late final favoriteFeatures = computed(
    () => allFeatures.value.where((feature) => feature.isFavorite).toList(),
  );

  Future<void> loadFeatures() async {
    allFeatures.value = await _featureRepository.getFeatures();
  }

  Future<void> togglePinned(int id) async {
    final features = allFeatures.value;
    final index = features.indexWhere((feature) => feature.id == id);
    if (index == -1) return;

    final feature = features[index];
    final newValue = !feature.isPinned;
    await _featureRepository.updatePinned(id, newValue);

    final updated = feature.copyWith(isPinned: newValue);
    final newList = [...features];
    newList[index] = updated;
    allFeatures.value = newList;
  }

  Future<void> toggleFavorite(int id) async {
    final features = allFeatures.value;
    final index = features.indexWhere((feature) => feature.id == id);
    if (index == -1) return;

    final feature = features[index];
    final newValue = !feature.isFavorite;
    await _featureRepository.updateFavorite(id, newValue);

    final updated = feature.copyWith(isFavorite: newValue);
    final newList = [...features];
    newList[index] = updated;
    allFeatures.value = newList;
  }

  // ========== DBC 导入 ==========

  final dbcImported = signal(false);
  final dbcPath = signal<String?>(null);
  final dbcImportError = signal<String?>(null);
  final dbcImporting = signal(false);
  final dbcImportCancelling = signal(false);
  final dbcProgress = signal<double?>(null);
  final dbcProgressLabel = signal('');
  final dbcProgressDetail = signal('');

  Future<void> checkAndImport() async {
    try {
      if (dbcImported.value) return;
      final missing = await _dbcSync.checkRequiredTablesExist();
      if (missing.isEmpty) {
        dbcImported.value = true;
        return;
      }
      final config = await _configUtil.load();
      final path = config['dbc_path']?.toString();
      if (path != null && path.isNotEmpty) dbcPath.value = path;
    } catch (error) {
      LoggerUtil.instance.e('检查 DBC 导入状态失败: $error');
      DialogUtil.instance.error('检查 DBC 导入状态失败: $error');
    }
  }

  void startImport() {
    if (dbcPath.value == null || dbcImporting.value) return;
    _startImportWorker();
  }

  Future<void> setDbcPath(String path) async {
    try {
      dbcPath.value = path;
      dbcImportError.value = null;
      await _configUtil.update({'dbc_path': path});
      _startImportWorker();
    } catch (error) {
      LoggerUtil.instance.e('设置 DBC 路径失败: $error');
      DialogUtil.instance.error('设置 DBC 路径失败: $error');
    }
  }

  Future<void> retryImport() async {
    if (dbcPath.value == null) {
      dbcImportError.value = null;
      return;
    }
    dbcImportError.value = null;
    _startImportWorker();
  }

  Future<void> cancelImport() async {
    if (!dbcImporting.value || dbcImportCancelling.value) return;
    dbcImportCancelling.value = true;
    await _dbcSync.cancel();
  }

  void _startImportWorker() {
    if (dbcImporting.value) return;
    final path = dbcPath.value;
    if (path == null) return;
    dbcImporting.value = true;
    dbcImportCancelling.value = false;
    dbcProgress.value = null;
    dbcProgressLabel.value = '准备导入...';
    dbcProgressDetail.value = '';
    dbcImportError.value = null;
    unawaited(_runImport(path));
  }

  Future<void> _runImport(String directory) async {
    try {
      final config = await _configUtil.load();
      final mysqlConfig = MysqlConfig(
        host: config['host']?.toString() ?? '127.0.0.1',
        port: _parsePort(config['port']),
        database: config['database']?.toString() ?? 'acore_world',
        username: config['username']?.toString() ?? 'acore',
        password: config['password']?.toString() ?? 'acore',
      );
      final stream = _dbcSync.import(
        directory: directory,
        mysqlConfig: mysqlConfig,
      );

      DbcSyncResult? result;
      await for (final progress in stream) {
        switch (progress) {
          case DbcSyncStatus(:final message):
            dbcProgressLabel.value = message;
          case DbcSyncCount(
            :final fileName,
            :final completedFiles,
            :final totalFiles,
            :final processedRows,
            :final totalRows,
          ):
            dbcProgress.value = totalFiles > 0
                ? completedFiles / totalFiles
                : null;
            dbcProgressLabel.value = fileName;
            final rowText = totalRows == null
                ? ''
                : '，当前文件 $processedRows / $totalRows 行';
            dbcProgressDetail.value =
                '已处理 $completedFiles / $totalFiles 个文件$rowText';
          case DbcSyncResult():
            result = progress;
        }
      }

      if (result == null) {
        throw StateError('DBC 导入任务结束但未返回结果');
      }
      await _handleImportResult(result);
    } catch (error) {
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
      await _verifyImportCompleted(
        completed: result.completed,
        skipped: result.skipped,
      );
      return;
    }

    _resetImportProgress();
    final top = result.errors.take(3).join('\n');
    dbcImportError.value =
        '导入完成，部分文件失败：\n$top'
        '${result.errors.length > 3 ? '\n...等 ${result.errors.length} 个错误' : ''}';
  }

  static int _parsePort(Object? value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 3306;
  }

  Future<void> _verifyImportCompleted({
    required int completed,
    required int skipped,
  }) async {
    try {
      dbcProgressLabel.value = '正在验证 DBC 数据...';
      final missing = await _dbcSync.checkRequiredTablesExist();
      if (missing.isNotEmpty) {
        dbcImportError.value =
            '导入完成，但仍缺少或为空的表：\n${missing.take(5).join('\n')}'
            '${missing.length > 5 ? '\n...等 ${missing.length} 张表' : ''}';
        return;
      }
      LoggerUtil.instance.i('DBC 导入完成: $completed 个, 跳过 $skipped 个');
      dbcImported.value = true;
    } catch (error) {
      dbcImportError.value = '导入后验证失败：$error';
    } finally {
      _resetImportProgress();
    }
  }

  void _resetImportProgress() {
    dbcImporting.value = false;
    dbcImportCancelling.value = false;
    dbcProgress.value = null;
    dbcProgressLabel.value = '';
    dbcProgressDetail.value = '';
  }
}
