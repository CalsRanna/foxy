import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/page/bootstrap/bootstrap_port.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';
import 'package:foxy/use_case/bootstrap/bootstrap_application_use_case.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:signals/signals.dart';

class BootstrapWorkflowViewModel with FieldControllerMixin {
  final BootstrapApplicationUseCase _useCase;
  final ConfigUtil _configUtil;

  final status = signal(WorkflowStatus.idle);
  final progress = signal<double?>(null);
  final progressLabel = signal('');
  final progressDetail = signal('');
  final errorMessage = signal<String?>(null);
  final result = signal<BootstrapApplicationResult?>(null);
  final version = signal('');

  late final hostController = registerController(StringFieldController());
  late final portController = registerController(StringFieldController());
  late final databaseController = registerController(StringFieldController());
  late final usernameController = registerController(StringFieldController());
  late final passwordController = registerController(StringFieldController());

  var _attemptToken = 0;

  BootstrapWorkflowViewModel({
    BootstrapApplicationUseCase? useCase,
    ConfigUtil? configUtil,
  }) : _useCase = useCase ?? GetIt.instance.get<BootstrapApplicationUseCase>(),
       _configUtil = configUtil ?? GetIt.instance.get<ConfigUtil>();

  bool get _isActive =>
      status.value == WorkflowStatus.preparing ||
      status.value == WorkflowStatus.running ||
      status.value == WorkflowStatus.cancelling;

  Future<void> cancel() async {
    // Database connection and migrations have no safe mid-flight cancellation.
  }

  void dispose() {
    _attemptToken++;
    disposeControllers();
  }

  Future<void> prepare() async {
    if (_isActive) return;
    final token = ++_attemptToken;
    status.value = WorkflowStatus.preparing;
    errorMessage.value = null;
    try {
      final config = await _configUtil.load();
      if (token != _attemptToken) return;
      hostController.init(config['host']?.toString() ?? '127.0.0.1');
      portController.init(config['port']?.toString() ?? '3306');
      databaseController.init(config['database']?.toString() ?? '');
      usernameController.init(config['username']?.toString() ?? '');
      passwordController.init(config['password']?.toString() ?? '');
      final packageInfo = await PackageInfo.fromPlatform();
      if (token != _attemptToken) return;
      version.value = '${packageInfo.version}+${packageInfo.buildNumber}';
      status.value = WorkflowStatus.idle;
    } catch (error) {
      if (token != _attemptToken) return;
      errorMessage.value = '加载连接配置失败: ${foxyErrorMessage(error)}';
      status.value = WorkflowStatus.failed;
      rethrow;
    }
  }

  void reset() {
    if (_isActive) return;
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

  Future<void> start() async {
    if (_isActive) return;
    final port = parseMysqlPort(portController.collect());
    if (port == null) {
      final error = ValidationException(
        'invalid port: enter an integer between 1 and 65535',
      );
      errorMessage.value = foxyErrorMessage(error);
      status.value = WorkflowStatus.failed;
      throw error;
    }

    final token = ++_attemptToken;
    status.value = WorkflowStatus.running;
    progress.value = null;
    progressLabel.value = '正在连接数据库...';
    progressDetail.value = '';
    errorMessage.value = null;
    result.value = null;
    try {
      // useSsl is not exposed to regular users: the UI has no switch, and
      // the use case reads the use_ssl key from config.yaml (recommended
      // for remote hosts).
      final nextResult = await _useCase.execute(
        BootstrapApplicationInput(
          host: hostController.collect(),
          port: port,
          database: databaseController.collect(),
          username: usernameController.collect(),
          password: passwordController.collect(),
        ),
      );
      if (token != _attemptToken) return;
      result.value = nextResult;
      progressLabel.value = '';
      status.value = WorkflowStatus.succeeded;
    } catch (error) {
      if (token != _attemptToken) return;
      progressLabel.value = '';
      errorMessage.value = foxyErrorMessage(error);
      status.value = WorkflowStatus.failed;
      rethrow;
    }
  }
}
