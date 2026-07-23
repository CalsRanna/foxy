import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/page/workflow/workflow_status.dart';
import 'package:foxy/use_case/dbc/export_dbc_use_case.dart';
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

  bool get canSelect => !countFailed;
  bool get countFailed => countError != null;
  String get dbcFileName => definition.fileName;

  String get recordCountLabel {
    if (countFailed) return '计数失败';
    final count = recordCount ?? 0;
    if (count == 0) return '空表';
    return '$count 条';
  }

  String get tableName => definition.tableName;

  DbcExportItem copyWith({bool? selected}) {
    return DbcExportItem(
      definition: definition,
      recordCount: recordCount,
      countError: countError,
      selected: selected ?? this.selected,
    );
  }
}

class DbcExportWorkflowViewModel {
  final ExportDbcUseCase _useCase;
  final ConfigUtil _configUtil;

  final status = signal(WorkflowStatus.idle);
  final progress = signal<double?>(null);
  final progressLabel = signal('');
  final progressDetail = signal('');
  final errorMessage = signal<String?>(null);
  final items = signal<List<DbcExportItem>>([]);
  final outputDirectory = signal<String?>(null);
  final result = signal<DbcSyncResult?>(null);

  var _attemptToken = 0;

  DbcExportWorkflowViewModel({
    ExportDbcUseCase? useCase,
    ConfigUtil? configUtil,
  }) : _useCase = useCase ?? GetIt.instance.get<ExportDbcUseCase>(),
       _configUtil = configUtil ?? GetIt.instance.get<ConfigUtil>();

  bool get allSelectableSelected {
    final selectable = selectableItems;
    return selectable.isNotEmpty && selectable.every((item) => item.selected);
  }

  int get countFailureCount =>
      items.value.where((item) => item.countFailed).length;

  bool get isRunning => _isActive || _useCase.isRunning;

  List<DbcExportItem> get selectableItems =>
      items.value.where((item) => item.canSelect).toList();

  List<DbcExportItem> get selectedExportableItems =>
      items.value.where((item) => item.selected && item.canSelect).toList();

  Future<void> prepare() async {
    if (_isActive) return;
    final token = ++_attemptToken;
    status.value = WorkflowStatus.preparing;
    errorMessage.value = null;
    result.value = null;
    try {
      final config = await _configUtil.load();
      if (token != _attemptToken) return;
      final configuredPath = config['dbc_path']?.toString().trim();
      outputDirectory.value = configuredPath == null || configuredPath.isEmpty
          ? null
          : configuredPath;
      final tables = await _useCase.loadTables();
      if (token != _attemptToken) return;
      items.value = [
        for (final table in tables)
          DbcExportItem(
            definition: table.definition,
            recordCount: table.recordCount,
            countError: table.countError?.toString(),
            selected: table.countError == null,
          ),
      ];
      status.value = WorkflowStatus.idle;
    } catch (error) {
      if (token != _attemptToken) return;
      errorMessage.value = '读取 DBC 表统计失败：$error';
      status.value = WorkflowStatus.failed;
      rethrow;
    }
  }

  Future<void> start() async {
    if (_isActive || _useCase.isRunning) return;
    final selected = selectedExportableItems;
    final directory = outputDirectory.value?.trim();
    if (selected.isEmpty) {
      final error = StateError('请至少选择一张可导出的 DBC 表');
      errorMessage.value = error.message;
      status.value = WorkflowStatus.failed;
      throw error;
    }
    if (directory == null || directory.isEmpty) {
      final error = StateError('请先选择 DBC 输出目录');
      errorMessage.value = error.message;
      status.value = WorkflowStatus.failed;
      throw error;
    }

    final token = ++_attemptToken;
    status.value = WorkflowStatus.preparing;
    progress.value = 0;
    progressLabel.value = '准备导出...';
    progressDetail.value = '';
    errorMessage.value = null;
    result.value = null;
    try {
      final nextResult = await _useCase.execute(
        ExportDbcInput(
          definitions: selected.map((item) => item.definition).toList(),
          outputDirectory: directory,
          onProgress: (event) => _applyProgress(token, event),
        ),
      );
      if (token != _attemptToken) return;
      result.value = nextResult;
      progress.value = null;
      progressLabel.value = '';
      progressDetail.value = '';
      if (nextResult.cancelled) {
        errorMessage.value = '导出已取消';
        status.value = WorkflowStatus.failed;
      } else if (nextResult.success) {
        status.value = WorkflowStatus.succeeded;
      } else {
        errorMessage.value = _formatFailure(nextResult);
        status.value = WorkflowStatus.failed;
      }
    } catch (error) {
      if (token != _attemptToken) return;
      progress.value = null;
      progressLabel.value = '';
      progressDetail.value = '';
      errorMessage.value = '导出出错：$error';
      status.value = WorkflowStatus.failed;
      rethrow;
    }
  }

  Future<void> cancel() async {
    if (!_isActive && !_useCase.isRunning) return;
    status.value = WorkflowStatus.cancelling;
    await _useCase.cancel();
  }

  Future<void> retry() async {
    errorMessage.value = null;
    await start();
  }

  void reset() {
    if (_isActive || _useCase.isRunning) return;
    _attemptToken++;
    status.value = WorkflowStatus.idle;
    progress.value = null;
    progressLabel.value = '';
    progressDetail.value = '';
    errorMessage.value = null;
    result.value = null;
  }

  void setOutputDirectory(String value) {
    final trimmed = value.trim();
    outputDirectory.value = trimmed.isEmpty ? null : trimmed;
  }

  void setAllSelectableSelected(bool selected) {
    items.value = [
      for (final item in items.value)
        item.copyWith(selected: item.canSelect && selected),
    ];
  }

  void setItemSelected(String tableName, bool selected) {
    final nextItems = [...items.value];
    final index = nextItems.indexWhere((item) => item.tableName == tableName);
    if (index == -1 || !nextItems[index].canSelect) return;
    nextItems[index] = nextItems[index].copyWith(selected: selected);
    items.value = nextItems;
  }

  void _applyProgress(int token, DbcSyncProgress event) {
    if (token != _attemptToken) return;
    status.value = WorkflowStatus.running;
    switch (event) {
      case DbcSyncStatus(:final message):
        progressLabel.value = message;
      case DbcSyncCount(
        :final fileName,
        :final completedFiles,
        :final totalFiles,
        :final processedRows,
      ):
        progress.value = totalFiles > 0 ? completedFiles / totalFiles : null;
        progressLabel.value = fileName;
        final rowText = processedRows > 0 ? '，$processedRows 行' : '';
        progressDetail.value = '已处理 $completedFiles / $totalFiles 个文件$rowText';
      case DbcSyncResult():
        break;
    }
  }

  static String _formatFailure(DbcSyncResult result) {
    final top = result.errors.take(5).join('\n');
    return '导出结束，部分文件失败（成功 ${result.completed}，跳过 ${result.skipped}）：\n'
        '$top${result.errors.length > 5 ? '\n...等 ${result.errors.length} 个错误' : ''}';
  }

  bool get _isActive =>
      status.value == WorkflowStatus.preparing ||
      status.value == WorkflowStatus.running ||
      status.value == WorkflowStatus.cancelling;

  void dispose() {
    _attemptToken++;
  }
}
