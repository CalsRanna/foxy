import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:foxy/database/database.dart';
import 'package:foxy/database/migration_runner.dart';
import 'package:foxy/page/foxy_app/foxy_view_model.dart';
import 'package:foxy/page/scaffold/scaffold_view_model.dart';
import 'package:foxy/repository/setting_repository.dart';
import 'package:foxy/repository/version_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/util/config_util.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:signals/signals.dart';

class BootstrapViewModel {
  final _settingRepo = GetIt.instance.get<SettingRepository>();
  final _repository = GetIt.instance.get<VersionRepository>();
  final _configUtil = GetIt.instance.get<ConfigUtil>();
  final version = signal('');

  final hostController = TextEditingController();
  final portController = TextEditingController();
  final databaseController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> connect(BuildContext context) async {
    try {
      DialogUtil.instance.loading();
      var config = MysqlConfig(
        database: databaseController.text,
        password: passwordController.text,
        host: hostController.text,
        port: int.parse(portController.text),
        username: usernameController.text,
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

      await _updateConfig();
      DialogUtil.instance.dismiss();
      if (!context.mounted) return;
      AutoRouter.of(context).replaceAll([DashboardRoute()]);
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error(e.toString());
    }
  }

  void dispose() {
    hostController.dispose();
    portController.dispose();
    databaseController.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  Future<void> initSignals() async {
    try {
      var config = await _configUtil.load();
      hostController.text = config['host']?.toString() ?? '127.0.0.1';
      portController.text = config['port']?.toString() ?? '3306';
      databaseController.text = config['database']?.toString() ?? '';
      usernameController.text = config['username']?.toString() ?? '';
      passwordController.text = config['password']?.toString() ?? '';
      final packageInfo = await PackageInfo.fromPlatform();
      version.value = '${packageInfo.version}+${packageInfo.buildNumber}';
    } catch (e) {
      LoggerUtil.instance.e('加载连接配置失败: $e');
      DialogUtil.instance.error('加载连接配置失败: $e');
    }
  }

  Future<void> _updateConfig() async {
    try {
      await _configUtil.update({
        'host': hostController.text,
        'port': portController.text,
        'database': databaseController.text,
        'username': usernameController.text,
        'password': passwordController.text,
      });
    } catch (e) {
      LoggerUtil.instance.e('保存配置文件失败: $e');
      DialogUtil.instance.error('保存配置文件失败: $e');
    }
  }
}
