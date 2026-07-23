import 'package:foxy/database/database.dart';
import 'package:foxy/database/migration_runner.dart';
import 'package:foxy/entity/feature_entity.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/feature_repository.dart';
import 'package:foxy/repository/setting_repository.dart';
import 'package:foxy/repository/version_repository.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

final class BootstrapApplicationInput {
  final String host;
  final int port;
  final String database;
  final String username;
  final String password;

  const BootstrapApplicationInput({
    required this.host,
    required this.port,
    required this.database,
    required this.username,
    required this.password,
  });
}

final class BootstrapApplicationResult {
  final bool hasLocaleTables;
  final bool localeEnabled;
  final List<FeatureEntity> features;
  final bool configSaved;

  const BootstrapApplicationResult({
    required this.hasLocaleTables,
    required this.localeEnabled,
    required this.features,
    required this.configSaved,
  });
}

final class BootstrapApplicationUseCase {
  final ConfigUtil _configUtil;
  final FeatureRepository _featureRepository;
  final SettingRepository _settingRepository;
  final VersionRepository _versionRepository;

  BootstrapApplicationUseCase({
    required ConfigUtil configUtil,
    required FeatureRepository featureRepository,
    required SettingRepository settingRepository,
    required VersionRepository versionRepository,
  }) : _configUtil = configUtil,
       _featureRepository = featureRepository,
       _settingRepository = settingRepository,
       _versionRepository = versionRepository;

  Future<BootstrapApplicationResult> execute(
    BootstrapApplicationInput input,
  ) async {
    final config = MysqlConfig(
      host: input.host,
      port: input.port,
      database: input.database,
      username: input.username,
      password: input.password,
    );
    await Database.instance.connect(
      config,
      onQuery: (query) => LoggerUtil.instance.d(query.sql),
    );
    await _versionRepository.connect();

    final hasLocaleTables = await _settingRepository.hasLocaleTables();
    final savedConfig = await _configUtil.load();
    var localeEnabled = savedConfig['locale_enabled'] == true;
    if (hasLocaleTables && !savedConfig.containsKey('locale_enabled')) {
      localeEnabled = true;
    }
    if (!hasLocaleTables) {
      localeEnabled = false;
    }

    await MigrationRunner(Database.instance.laconic).run();
    final features = await _featureRepository.getFeatures();

    var configSaved = true;
    try {
      await _configUtil.update({
        'host': input.host,
        'port': input.port.toString(),
        'database': input.database,
        'username': input.username,
        'password': input.password,
      });
    } catch (error) {
      configSaved = false;
      LoggerUtil.instance.e('保存配置文件失败: $error');
    }

    return BootstrapApplicationResult(
      hasLocaleTables: hasLocaleTables,
      localeEnabled: localeEnabled,
      features: List.unmodifiable(features),
      configSaved: configSaved,
    );
  }
}
