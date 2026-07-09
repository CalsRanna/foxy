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
/// 导出对话框中单个可选 DBC 表的数据模型（不可变，通过 [copyWith] 更新选中状态）。
class DbcExportItem {
  final String tableShort;
  final String dbcFileName;
  final int recordCount;
  final bool selected;

  const DbcExportItem({
    required this.tableShort,
    required this.dbcFileName,
    this.recordCount = 0,
    this.selected = true,
  });

  DbcExportItem copyWith({bool? selected}) {
    return DbcExportItem(
      tableShort: tableShort,
      dbcFileName: dbcFileName,
      recordCount: recordCount,
      selected: selected ?? this.selected,
    );
  }
}

class ScaffoldViewModel {
  final _featureRepository = GetIt.instance.get<FeatureRepository>();
  final _dbcSync = DbcSyncUtil();
  final _dbcExport = DbcExportUtil();

  // ========== 功能模块 ==========

  final allFeatures = signal<List<FeatureEntity>>([]);

  late final pinnedFeatures = computed(
    () => allFeatures.value.where((f) => f.isPinned).toList(),
  );

  late final favoriteFeatures = computed(
    () => allFeatures.value.where((f) => f.isFavorite).toList(),
  );

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

  // ========== DBC 导出 ==========

  final dbcExportItems = signal<List<DbcExportItem>>([]);
  final dbcExporting = signal(false);
  final dbcExportProgress = signal<double?>(null);
  final dbcExportProgressLabel = signal('');
  final dbcExportProgressDetail = signal('');
  final dbcExportError = signal<String?>(null);
  final dbcExportSuccess = signal(false);
  StreamSubscription<DbcSyncProgress>? _exportSub;

  /// 加载可导出表清单及行数预览（供导出对话框展示）。
  Future<void> loadExportItems() async {
    try {
      final counts = await _dbcExport.getTableRecordCounts();
      dbcExportItems.value = kTableSchemaMap.entries.map((e) {
        return DbcExportItem(
          tableShort: e.key,
          dbcFileName: kTableDbcNameMap[e.key] ?? '${e.value.name}.dbc',
          recordCount: counts[e.key] ?? 0,
          selected: true,
        );
      }).toList()
        ..sort((a, b) => a.dbcFileName.compareTo(b.dbcFileName));
    } catch (e) {
      LoggerUtil.instance.e('加载导出表清单失败: $e');
    }
  }

  /// 执行导出：将用户选中的表写回 .dbc 文件。
  Future<bool> exportDbc(String outputDir) async {
    final selected = dbcExportItems.value
        .where((e) => e.selected)
        .map((e) => e.tableShort)
        .toList();
    LoggerUtil.instance
        .i('exportDbc 被调用, outputDir=$outputDir, selected=$selected');
    if (selected.isEmpty) {
      LoggerUtil.instance.e('exportDbc: 没有选中的表，取消导出');
      return false;
    }
    if (dbcExporting.value) {
      LoggerUtil.instance.e('exportDbc: 正在导出中，忽略重复点击');
      return false;
    }

    dbcExporting.value = true;
    dbcExportProgress.value = null;
    dbcExportProgressLabel.value = '准备导出...';
    dbcExportProgressDetail.value = '';
    dbcExportError.value = null;
    dbcExportSuccess.value = false;

    return _runExport(outputDir, selected);
  }

  /// 重新导出（重试）。
  Future<bool> retryExport(String outputDir) async {
    dbcExportError.value = null;
    dbcExportSuccess.value = false;
    final selected = dbcExportItems.value
        .where((e) => e.selected)
        .map((e) => e.tableShort)
        .toList();
    if (selected.isEmpty) return false;
    return _runExport(outputDir, selected);
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

  Future<bool> _runExport(String outputDir, List<String> tableShorts) async {
    try {
      // 数据经 Repository.get{Entities} 读取（DbcExportRegistry），不再在 isolate 内 SELECT *
      final stream = _dbcExport.export(
        outputDir: outputDir,
        tableShorts: tableShorts,
      );

      final completer = Completer<bool>();
      _exportSub = stream.listen(
        (progress) {
          switch (progress) {
            case DbcSyncStatus(:final status):
              dbcExportProgressLabel.value = status;
            case DbcSyncCount(:final status, :final done, :final total):
              dbcExportProgress.value = total > 0 ? done / total : null;
              dbcExportProgressLabel.value = status;
              dbcExportProgressDetail.value = '已处理 $done / $total 个文件';
            case DbcSyncResult(
              :final success,
              :final imported,
              :final skipped,
              :final errors,
            ):
              _exportSub?.cancel();
              _exportSub = null;
              dbcExporting.value = false;
              dbcExportProgress.value = null;
              dbcExportProgressLabel.value = '';
              dbcExportProgressDetail.value = '';
              if (success) {
                LoggerUtil.instance.i('DBC 导出完成: $imported 个, 跳过 $skipped 个');
                dbcExportSuccess.value = true;
                completer.complete(true);
              } else {
                final top = errors.take(3).join('\n');
                dbcExportError.value =
                    '导出完成，部分文件失败：\n$top'
                    '${errors.length > 3 ? '\n...等 ${errors.length} 个错误' : ''}';
                completer.complete(false);
              }
          }
        },
        onDone: () {
          if (dbcExporting.value) {
            dbcExporting.value = false;
            dbcExportProgress.value = null;
          }
          if (!completer.isCompleted) completer.complete(false);
        },
      );
      return completer.future;
    } catch (e) {
      dbcExporting.value = false;
      dbcExportProgress.value = null;
      dbcExportError.value = '导出出错：$e';
      LoggerUtil.instance.e('DBC 导出异常: $e');
      return false;
    }
  }
}
