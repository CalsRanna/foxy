import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_summary.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';
import 'package:foxy/view_model/dbc_export_workflow_view_model.dart';
import 'package:foxy/use_case/mpq/mpq_export_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart' as p;
import 'package:signals/signals.dart';

/// Default patch MPQ file name (editable in the export dialog).
const defaultMpqPatchFileName = 'patch-zhCN-5.mpq';

class MpqExportWorkflowViewModel {
  final MpqExportUseCase _useCase;
  final ConfigUtil _configUtil;

  final status = signal(WorkflowStatus.idle);
  final progress = signal<double?>(null);
  final progressLabel = signal('');
  final progressDetail = signal('');
  final errorMessage = signal<String?>(null);
  final items = signal<List<DbcExportItem>>([]);
  final outputDirectory = signal<String?>(null);
  final fileName = signal(defaultMpqPatchFileName);
  final result = signal<DbcSyncResult?>(null);

  var _attemptToken = 0;

  MpqExportWorkflowViewModel({
    MpqExportUseCase? useCase,
    ConfigUtil? configUtil,
  }) : _useCase = useCase ?? GetIt.instance.get<MpqExportUseCase>(),
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

  bool get _isActive =>
      status.value == WorkflowStatus.preparing ||
      status.value == WorkflowStatus.running ||
      status.value == WorkflowStatus.cancelling;

  Future<void> cancel() async {
    if (!_isActive && !_useCase.isRunning) return;
    status.value = WorkflowStatus.cancelling;
    await _useCase.cancel();
  }

  void dispose() {
    _attemptToken++;
  }

  Future<void> prepare() async {
    if (_isActive) return;
    final token = ++_attemptToken;
    status.value = WorkflowStatus.preparing;
    errorMessage.value = null;
    result.value = null;
    try {
      final config = await _configUtil.load();
      if (token != _attemptToken) return;
      final configuredPath = config['mpq_dir']?.toString().trim();
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
      errorMessage.value = '读取 DBC 表统计失败：${foxyErrorMessage(error)}';
      status.value = WorkflowStatus.failed;
      rethrow;
    }
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

  Future<void> retry() async {
    errorMessage.value = null;
    await start();
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

  void setOutputDirectory(String value) {
    final trimmed = value.trim();
    outputDirectory.value = trimmed.isEmpty ? null : trimmed;
  }

  void setFileName(String value) {
    final trimmed = value.trim();
    fileName.value = trimmed.isEmpty ? defaultMpqPatchFileName : trimmed;
  }

  Future<void> start() async {
    if (_isActive || _useCase.isRunning) return;
    final selected = selectedExportableItems;
    final directory = outputDirectory.value?.trim();
    final name = fileName.value.trim();
    if (selected.isEmpty) {
      final error = ValidationException(
        'select at least one DBC table to export',
      );
      errorMessage.value = foxyErrorMessage(error);
      status.value = WorkflowStatus.failed;
      throw error;
    }
    if (directory == null || directory.isEmpty) {
      final error = ValidationException('select the MPQ output directory first');
      errorMessage.value = foxyErrorMessage(error);
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
        MpqExportInput(
          definitions: selected.map((item) => item.definition).toList(),
          mpqFilePath: p.join(directory, name),
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
        errorMessage.value = formatDbcSyncFailureSummary(nextResult, '导出');
        status.value = WorkflowStatus.failed;
      }
    } catch (error) {
      if (token != _attemptToken) return;
      progress.value = null;
      progressLabel.value = '';
      progressDetail.value = '';
      errorMessage.value = '导出出错：${foxyErrorMessage(error)}';
      status.value = WorkflowStatus.failed;
      rethrow;
    }
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
}
