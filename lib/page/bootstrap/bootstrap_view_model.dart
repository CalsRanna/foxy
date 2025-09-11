import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/foxy_app/foxy_view_model.dart';
import 'package:foxy/repository/version_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:signals/signals.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

class BootstrapViewModel {
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
      var laconic = Laconic.mysql(
        config,
        listen: (query) => logger.d(query.rawSql),
      );
      var foxyViewModel = GetIt.instance.get<FoxyViewModel>();
      foxyViewModel.initSignals(laconic);
      await VersionRepository().connect();
      await _updateConfig();
      DialogUtil.instance.dismiss();
      if (!context.mounted) return;
      AutoRouter.of(context).replaceAll([DashboardRoute()]);
    } catch (e) {
      DialogUtil.instance.dismiss();
      logger.e(e.toString());
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
    var config = await _loadConfig();
    hostController.text = config['host']!;
    portController.text = config['port']!;
    databaseController.text = config['database']!;
    usernameController.text = config['username']!;
    passwordController.text = config['password']!;
    final packageInfo = await PackageInfo.fromPlatform();
    version.value = '${packageInfo.version}+${packageInfo.buildNumber}';
  }

  Future<Map<String, String>> _loadConfig() async {
    var currentDirectory = Directory.current;
    var path = join(currentDirectory.path, 'config.yaml');
    var file = File(path);
    if (!await file.exists()) await file.create(recursive: true);
    var content = await file.readAsString();
    if (content.isNotEmpty) return Map.from(loadYaml(content));
    var defaultConfig = {
      'host': '127.0.0.1',
      'port': '3306',
      'database': 'arcane_world',
      'username': 'root',
      'password': 'root',
    };
    var editor = YamlEditor('');
    editor.update([], defaultConfig);
    await file.writeAsString(editor.toString());
    return defaultConfig;
  }

  Future<void> _updateConfig() async {
    var editor = YamlEditor('');
    var config = {
      'host': hostController.text,
      'port': portController.text,
      'database': databaseController.text,
      'username': usernameController.text,
      'password': passwordController.text,
    };
    editor.update([], config);
    var currentDirectory = Directory.current;
    var path = join(currentDirectory.path, 'config.yaml');
    var file = File(path);
    if (!await file.exists()) await file.create(recursive: true);
    await file.writeAsString(editor.toString());
  }
}
