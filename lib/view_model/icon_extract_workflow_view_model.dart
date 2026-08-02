import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_extractor.dart';
import 'package:foxy/page/workflow/workflow_status.dart';
import 'package:foxy/use_case/game_asset/extract_game_icons_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class IconExtractWorkflowViewModel {
  final ExtractGameIconsUseCase _useCase;
  final ConfigUtil _configUtil;

  final status = signal(WorkflowStatus.idle);
  final progress = signal<double?>(null);
  final progressLabel = signal('');
  final progressDetail = signal('');
  final errorMessage = signal<String?>(null);
  final path = signal<String?>(null);
  final result = signal<GameIconExtractionResult?>(null);

  var _attemptToken = 0;

  IconExtractWorkflowViewModel({
    ExtractGameIconsUseCase? useCase,
    ConfigUtil? configUtil,
  }) : _useCase = useCase ?? GetIt.instance.get<ExtractGameIconsUseCase>(),
       _configUtil = configUtil ?? GetIt.instance.get<ConfigUtil>();

  bool get isRunning => _isActive || _useCase.isRunning;

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
    try {
      final config = await _configUtil.load();
      if (token != _attemptToken) return;
      final configuredPath = config['client_dir']?.toString().trim();
      path.value = configuredPath == null || configuredPath.isEmpty
          ? null
          : configuredPath;
      status.value = WorkflowStatus.idle;
    } catch (error) {
      if (token != _attemptToken) return;
      errorMessage.value = '加载客户端配置失败: ${foxyErrorMessage(error)}';
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
      final error = ValidationException('select the client directory first');
      errorMessage.value = foxyErrorMessage(error);
      status.value = WorkflowStatus.failed;
      throw error;
    }

    final token = ++_attemptToken;
    status.value = WorkflowStatus.preparing;
    progress.value = 0;
    progressLabel.value = '准备提取...';
    progressDetail.value = '';
    errorMessage.value = null;
    result.value = null;
    try {
      final nextResult = await _useCase.execute(
        ExtractGameIconsInput(
          clientDir: directory,
          onProgress: (event) => _applyProgress(token, event),
        ),
      );
      if (token != _attemptToken) return;
      result.value = nextResult;
      progress.value = null;
      progressLabel.value = '';
      progressDetail.value = '';
      if (nextResult.cancelled) {
        errorMessage.value = '提取已取消';
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
      errorMessage.value = '提取出错：${foxyErrorMessage(error)}';
      status.value = WorkflowStatus.failed;
      rethrow;
    }
  }

  void _applyProgress(int token, GameIconExtractProgress event) {
    if (token != _attemptToken) return;
    status.value = WorkflowStatus.running;
    switch (event) {
      case GameIconExtractStatus(:final message):
        progressLabel.value = message;
      case GameIconExtractCount(
        :final fileName,
        :final completed,
        :final total,
      ):
        progress.value = total > 0 ? completed / total : null;
        progressLabel.value = fileName;
        progressDetail.value = '已处理 $completed / $total 个图标';
      case GameIconExtractionResult():
        break;
    }
  }

  static String _formatFailure(GameIconExtractionResult result) {
    final top = result.errors.take(5).join('\n');
    final suffix = result.errors.length > 5
        ? '\n...等 ${result.errors.length} 个错误'
        : '';
    return '提取结束，部分文件失败（成功 ${result.extracted}，跳过 ${result.skipped}）：\n'
        '$top$suffix';
  }
}
