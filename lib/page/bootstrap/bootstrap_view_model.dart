import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:foxy/database/database.dart';
import 'package:foxy/database/migration_runner.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/page/bootstrap/bootstrap_port.dart';
import 'package:foxy/page/foxy_app/foxy_view_model.dart';
import 'package:foxy/page/scaffold/scaffold_view_model.dart';
import 'package:foxy/repository/setting_repository.dart';
import 'package:foxy/repository/version_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:signals/signals.dart';

class BootstrapViewModel with FieldControllerMixin {
  final _settingRepo = GetIt.instance.get<SettingRepository>();
  final _repository = GetIt.instance.get<VersionRepository>();
  final _configUtil = GetIt.instance.get<ConfigUtil>();
  final version = signal('');

  late final hostController = registerController(StringFieldController());
  late final portController = registerController(StringFieldController());
  late final databaseController = registerController(StringFieldController());
  late final usernameController = registerController(StringFieldController());
  late final passwordController = registerController(StringFieldController());

  Future<void> connect(BuildContext context) async {
    final port = parseMysqlPort(portController.collect());
    if (port == null) {
      DialogUtil.instance.error('端口无效：请输入 1–65535 之间的整数');
      return;
    }

    var loadingShown = false;
    try {
      DialogUtil.instance.loading();
      loadingShown = true;

      var config = MysqlConfig(
        database: databaseController.collect(),
        password: passwordController.collect(),
        host: hostController.collect(),
        port: port,
        username: usernameController.collect(),
      );
      await Database.instance.connect(
        config,
        onQuery: (query) => LoggerUtil.instance.d(query.sql),
      );
      var foxyViewModel = GetIt.instance.get<FoxyViewModel>();
      await _repository.connect();

      // Check for locale tables and load locale settings
      var hasLocaleTables = await _settingRepo.hasLocaleTables();
      var savedConfig = await _configUtil.load();
      var localeEnabled = savedConfig['locale_enabled'] == true;
      // Auto-enable locale if tables exist and not explicitly set
      if (hasLocaleTables && !savedConfig.containsKey('locale_enabled')) {
        localeEnabled = true;
      }
      // Disable locale if no tables exist
      if (!hasLocaleTables) {
        localeEnabled = false;
      }
      foxyViewModel.setLocaleSettings(
        hasLocaleTables: hasLocaleTables,
        localeEnabled: localeEnabled,
      );

      // 运行数据库迁移
      await MigrationRunner(Database.instance.laconic).run();

      // 加载 features 数据
      await GetIt.instance.get<ScaffoldViewModel>().loadFeatures();

      // 先关闭 loading，再处理配置持久化，避免 error/alert 与 dismiss 竞态
      await DialogUtil.instance.dismiss();
      loadingShown = false;

      // 配置保存失败为非致命：连接/迁移已成功，仍可进入 Dashboard
      final configSaved = await _tryUpdateConfig();
      if (!configSaved) {
        await DialogUtil.instance.alert(
          title: '警告',
          message: '数据库连接成功，但配置文件保存失败。本次可继续使用；下次启动可能需要重新填写连接信息。',
        );
      }

      if (!context.mounted) return;
      AutoRouter.of(context).replaceAll([DashboardRoute()]);
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      if (loadingShown) {
        await DialogUtil.instance.dismiss();
        loadingShown = false;
      }
      DialogUtil.instance.error(e.toString());
    }
  }

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals() async {
    try {
      var config = await _configUtil.load();
      hostController.init(config['host']?.toString() ?? '127.0.0.1');
      portController.init(config['port']?.toString() ?? '3306');
      databaseController.init(config['database']?.toString() ?? '');
      usernameController.init(config['username']?.toString() ?? '');
      passwordController.init(config['password']?.toString() ?? '');
      final packageInfo = await PackageInfo.fromPlatform();
      version.value = '${packageInfo.version}+${packageInfo.buildNumber}';
    } catch (e) {
      LoggerUtil.instance.e('加载连接配置失败: $e');
      DialogUtil.instance.error('加载连接配置失败: $e');
    }
  }

  /// 尝试持久化连接配置。成功返回 true；失败只记日志并返回 false，不弹 Dialog。
  Future<bool> _tryUpdateConfig() async {
    try {
      await _configUtil.update({
        'host': hostController.collect(),
        'port': portController.collect(),
        'database': databaseController.collect(),
        'username': usernameController.collect(),
        'password': passwordController.collect(),
      });
      return true;
    } catch (e) {
      LoggerUtil.instance.e('保存配置文件失败: $e');
      return false;
    }
  }
}
