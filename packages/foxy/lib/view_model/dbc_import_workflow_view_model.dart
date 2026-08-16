import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_summary.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';
import 'package:foxy/use_case/dbc/import_dbc_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class DbcImportWorkflowViewModel {
  static String formatBlockingMessage(List<DbcTableCheckResult> blocking) {
    final hasIncompatible = blocking.any(
      (result) => result.state == DbcTableState.incompatible,
    );
    final title = hasIncompatible ? 'DBC 表结构不兼容' : 'DBC 表检查失败';
    final details = blocking
        .take(5)
        .map((result) {
          final message = result.message;
          if (message == null || message.isEmpty) {
            return '${result.tableName} (${result.state.name})';
          }
          return '${result.tableName}: $message';
        })
        .join('\n');
    final suffix = blocking.length > 5 ? '\n...等 ${blocking.length} 张表' : '';
    return '$title\n$details$suffix';
  }

  final ImportDbcUseCase _useCase;
  final ConfigUtil _configUtil;

  final status = signal(WorkflowStatus.idle);
  final progress = signal<double?>(null);
  final progressLabel = signal('');
  final progressDetail = signal('');
  final errorMessage = signal<String?>(null);
  final path = signal<String?>(null);
  final result = signal<DbcSyncResult?>(null);
  final tableCheckResults = signal<List<DbcTableCheckResult>>([]);

  var _attemptToken = 0;

  DbcImportWorkflowViewModel({
    ImportDbcUseCase? useCase,
    ConfigUtil? configUtil,
  }) : _useCase = useCase ?? GetIt.instance.get<ImportDbcUseCase>(),
       _configUtil = configUtil ?? GetIt.instance.get<ConfigUtil>();

  List<DbcTableCheckResult> get blockingTableChecks => tableCheckResults.value
      .where(
        (result) =>
            result.state == DbcTableState.error ||
            result.state == DbcTableState.incompatible,
      )
      .toList();

  bool get isRunning => _isActive || _useCase.isRunning;

  bool get tablesReady =>
      tableCheckResults.value.isNotEmpty &&
      tableCheckResults.value.every(
        (result) => result.state == DbcTableState.ready,
      );

  bool get _isActive =>
      status.value == WorkflowStatus.preparing ||
      status.value == WorkflowStatus.running ||
      status.value == WorkflowStatus.cancelling;

  Future<void> cancel() async {
    if (!_isActive && !_useCase.isRunning) return;
    status.value = WorkflowStatus.cancelling;
    await _useCase.cancel();
  }

  Future<void> checkTables() async {
    if (_isActive) return;
    final token = ++_attemptToken;
    status.value = WorkflowStatus.preparing;
    errorMessage.value = null;
    try {
      final checks = await _useCase.checkTables();
      if (token != _attemptToken) return;
      tableCheckResults.value = List.unmodifiable(checks);
      final blocking = blockingTableChecks;
      if (blocking.isNotEmpty) {
        errorMessage.value = formatBlockingMessage(blocking);
        status.value = WorkflowStatus.failed;
      } else {
        status.value = WorkflowStatus.idle;
      }
    } catch (error) {
      if (token != _attemptToken) return;
      errorMessage.value = '检查 DBC 导入状态失败: ${FoxyExceptions.message(error)}';
      status.value = WorkflowStatus.failed;
    }
  }

  void dispose() {
    _attemptToken++;
  }

  Future<void> prepare() async {
    if (_isActive) return;
    final token = ++_attemptToken;
    status.value = WorkflowStatus.preparing;
    errorMessage.value = null;
    try {
      final config = await _configUtil.load();
      if (token != _attemptToken) return;
      final configuredPath = config['dbc_dir']?.toString().trim();
      path.value = configuredPath == null || configuredPath.isEmpty
          ? null
          : configuredPath;
      status.value = WorkflowStatus.idle;
    } catch (error) {
      if (token != _attemptToken) return;
      errorMessage.value = '加载 DBC 配置失败: ${FoxyExceptions.message(error)}';
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

  void setPath(String value) {
    final trimmed = value.trim();
    path.value = trimmed.isEmpty ? null : trimmed;
  }

  Future<void> start() async {
    if (_isActive || _useCase.isRunning) return;
    final directory = path.value?.trim();
    if (directory == null || directory.isEmpty) {
      final error = ValidationException('select the DBC file directory first');
      errorMessage.value = FoxyExceptions.message(error);
      status.value = WorkflowStatus.failed;
      throw error;
    }

    final token = ++_attemptToken;
    status.value = WorkflowStatus.preparing;
    progress.value = 0;
    progressLabel.value = '准备导入...';
    progressDetail.value = '';
    errorMessage.value = null;
    result.value = null;
    try {
      final nextResult = await _useCase.execute(
        ImportDbcInput(
          directory: directory,
          onProgress: (event) => _applyProgress(token, event),
        ),
      );
      if (token != _attemptToken) return;
      result.value = nextResult;
      progress.value = null;
      progressLabel.value = '';
      progressDetail.value = '';
      if (nextResult.cancelled) {
        errorMessage.value = '导入已取消';
        status.value = WorkflowStatus.failed;
      } else if (nextResult.success) {
        status.value = WorkflowStatus.succeeded;
      } else {
        errorMessage.value = DbcSyncSummary.dbcSyncFailureSummary(
          nextResult,
          '导入',
        );
        status.value = WorkflowStatus.failed;
      }
    } catch (error) {
      if (token != _attemptToken) return;
      progress.value = null;
      progressLabel.value = '';
      progressDetail.value = '';
      errorMessage.value = '导入出错：${FoxyExceptions.message(error)}';
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
        :final totalRows,
      ):
        progress.value = totalFiles > 0 ? completedFiles / totalFiles : null;
        progressLabel.value = fileName;
        final rowText = totalRows == null
            ? '$processedRows 行'
            : '$processedRows / $totalRows 行';
        progressDetail.value = '已处理 $completedFiles / $totalFiles 个文件，$rowText';
      case DbcSyncResult():
        break;
    }
  }
}
