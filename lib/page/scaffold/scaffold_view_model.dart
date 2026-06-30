import 'dart:async';

import 'package:foxy/entity/feature_entity.dart';
import 'package:foxy/repository/feature_repository.dart';
import 'package:foxy/util/dbc_sync_util.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

/// 应用根外壳的 ViewModel：聚合「功能模块清单」与「DBC 数据导入」两块
/// 应用级运行时状态。两者生命周期相同（整个 app 运行期），由 scaffold
/// 阶段消费。
class ScaffoldViewModel {
  final _featureRepository = GetIt.instance.get<FeatureRepository>();
  final _dbcSync = DbcSyncUtil();

  // ========== 功能模块 ==========

  final allFeatures = signal<List<FeatureEntity>>([]);

  List<FeatureEntity> get pinnedFeatures =>
      allFeatures.value.where((f) => f.isPinned).toList();

  List<FeatureEntity> get favoriteFeatures =>
      allFeatures.value.where((f) => f.isFavorite).toList();

  Future<void> loadFeatures() async {
    allFeatures.value = await _featureRepository.getFeatures();
  }

  Future<void> togglePinned(int id) async {
    final features = allFeatures.value;
    final index = features.indexWhere((f) => f.id == id);
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
    final index = features.indexWhere((f) => f.id == id);
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
  final dbcProgress = signal<double?>(null);
  final dbcProgressLabel = signal('');
  final dbcProgressDetail = signal('');
  StreamSubscription<DbcSyncProgress>? _importSub;

  /// 检查 DBC 数据是否就绪；未就绪则尝试从配置恢复路径。
  Future<void> checkAndImport() async {
    try {
      if (dbcImported.value) return;
      final missing = await _dbcSync.checkRequiredTablesExist();
      if (missing.isEmpty) {
        dbcImported.value = true;
        return;
      }
      final config = await _dbcSync.loadConfig();
      final path = config['dbc_path'] as String?;
      if (path != null && path.isNotEmpty) dbcPath.value = path;
    } catch (e) {
      LoggerUtil.instance.e('检查DBC导入状态失败: $e');
      DialogUtil.instance.error('检查DBC导入状态失败: $e');
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
      await _dbcSync.updateConfig('dbc_path', path);
      _startImportWorker();
    } catch (e) {
      LoggerUtil.instance.e('设置DBC路径失败: $e');
      DialogUtil.instance.error('设置DBC路径失败: $e');
    }
  }

  Future<void> retryImport() async {
    // 未配置路径时不能导入：清空错误回到路径输入界面，避免 dbcPath.value! 崩溃
    if (dbcPath.value == null) {
      dbcImportError.value = null;
      return;
    }
    try {
      dbcImportError.value = null;
      _startImportWorker();
    } catch (e) {
      LoggerUtil.instance.e('重试DBC导入失败: $e');
      DialogUtil.instance.error('重试DBC导入失败: $e');
    }
  }

  void _startImportWorker() {
    if (dbcImporting.value) return; // 防重入：setDbcPath/重试可能在导入中再次触发
    final path = dbcPath.value;
    if (path == null) return;
    dbcImporting.value = true;
    dbcProgress.value = null;
    dbcProgressLabel.value = '准备导入...';
    dbcProgressDetail.value = '';
    dbcImportError.value = null;

    _runImport(path).catchError((_) {});
  }

  Future<void> _runImport(String dbcPath) async {
    try {
      final config = await _dbcSync.loadConfig();
      final stream = _dbcSync.import(
        dbcPath: dbcPath,
        host: config['host'] as String? ?? '127.0.0.1',
        port: int.tryParse(config['port'] as String? ?? '3306') ?? 3306,
        database: config['database'] as String? ?? 'acore_world',
        username: config['username'] as String? ?? 'acore',
        password: config['password'] as String? ?? 'acore',
      );

      _importSub = stream.listen(
        (progress) {
          switch (progress) {
            case DbcSyncStatus(:final status):
              dbcProgressLabel.value = status;
            case DbcSyncCount(:final status, :final done, :final total):
              dbcProgress.value = total > 0 ? done / total : null;
              dbcProgressLabel.value = status;
              dbcProgressDetail.value = '已处理 $done / $total 个文件';
            case DbcSyncResult(
              :final success,
              :final imported,
              :final skipped,
              :final errors,
            ):
              _importSub?.cancel();
              _importSub = null;
              dbcImporting.value = false;
              dbcProgress.value = null;
              dbcProgressLabel.value = '';
              dbcProgressDetail.value = '';
              if (success) {
                LoggerUtil.instance.i('DBC 导入完成: $imported 个, 跳过 $skipped 个');
                dbcImported.value = true;
              } else {
                final top = errors.take(3).join('\n');
                dbcImportError.value =
                    '导入完成，部分文件失败：\n$top'
                    '${errors.length > 3 ? '\n...等 ${errors.length} 个错误' : ''}';
              }
          }
        },
        onDone: () {
          // 异常兜底：流关闭但未收到 Result（如 isolate 崩溃）
          if (dbcImporting.value) {
            dbcImporting.value = false;
            dbcProgress.value = null;
          }
        },
      );
    } catch (e) {
      dbcImporting.value = false;
      dbcProgress.value = null;
      dbcImportError.value = '导入出错：$e';
      LoggerUtil.instance.e('DBC 导入异常: $e');
    }
  }
}
