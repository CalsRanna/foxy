import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/page/foxy_app/foxy_view_model.dart';
import 'package:foxy/util/config_util.dart';
import 'package:foxy/util/dbc_export_registry.dart';
import 'package:foxy/util/dbc_sync_progress.dart';
import 'package:foxy/util/dbc_sync_util.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
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

  /// 列表展示用的行数文案：区分空表与计数失败。
  String get recordCountLabel {
    if (countFailed) return '计数失败';
    final count = recordCount ?? 0;
    if (count == 0) return '空';
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
  final _foxyViewModel = GetIt.instance.get<FoxyViewModel>();
  final _configUtil = GetIt.instance.get<ConfigUtil>();
  final _dbcSync = GetIt.instance.get<DbcSyncUtil>();
  final _dbcExportRegistry = GetIt.instance.get<DbcExportRegistry>();

  /// 供 Page 订阅；底层状态仍由 [FoxyViewModel] 持有。
  Signal<bool> get hasLocaleTables => _foxyViewModel.hasLocaleTables;
  Signal<bool> get localeEnabled => _foxyViewModel.localeEnabled;

  final dbcExportItems = signal<List<DbcExportItem>>([]);
  final dbcExporting = signal(false);
  final dbcExportProgress = signal<double?>(null);
  final dbcExportProgressLabel = signal('');
  final dbcExportProgressDetail = signal('');
  final dbcExportError = signal<String?>(null);
  final dbcExportSuccess = signal(false);

  Future<void> initSignals() async {
    // FoxyViewModel 的 signal 由 bootstrap 阶段填充，无需额外加载。
  }

  Future<void> setLocaleEnabled(bool value) async {
    try {
      if (!hasLocaleTables.value && value) return;
      localeEnabled.value = value;
      await _configUtil.update({'locale_enabled': value});
    } catch (error) {
      LoggerUtil.instance.e('设置本地化开关失败: $error');
      DialogUtil.instance.error('设置本地化开关失败: $error');
    }
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

  Future<bool> exportDbc(String outputDirectory) {
    return _startExport(outputDirectory);
  }

  Future<bool> retryExport(String outputDirectory) {
    return _startExport(outputDirectory);
  }

  Future<bool> _startExport(String outputDirectory) async {
    final selected = dbcExportItems.value
        .where((item) => item.selected)
        .toList();
    if (selected.isEmpty || dbcExporting.value) return false;

    dbcExporting.value = true;
    dbcExportProgress.value = 0;
    dbcExportProgressLabel.value = '准备导出...';
    dbcExportProgressDetail.value = '';
    dbcExportError.value = null;
    dbcExportSuccess.value = false;

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
        LoggerUtil.instance.i(
          'DBC 导出完成: ${result.completed} 个, 跳过 ${result.skipped} 个',
        );
        dbcExportSuccess.value = true;
        return true;
      }

      final top = result.errors.take(3).join('\n');
      dbcExportError.value =
          '导出完成，部分文件失败：\n$top'
          '${result.errors.length > 3 ? '\n...等 ${result.errors.length} 个错误' : ''}';
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
}
