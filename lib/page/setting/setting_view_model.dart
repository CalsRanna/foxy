import 'dart:io';

import 'package:foxy/page/foxy_app/foxy_view_model.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:signals/signals.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

class SettingViewModel {
  final localeEnabled = signal(false);
  final hasLocaleTables = signal(false);

  Future<void> initSignals() async {
    try {
      var foxyViewModel = GetIt.instance.get<FoxyViewModel>();
      hasLocaleTables.value = foxyViewModel.hasLocaleTables;
      localeEnabled.value = foxyViewModel.localeEnabled;
    } catch (e) {
      LoggerUtil.instance.e('加载设置失败: $e');
      DialogUtil.instance.error('加载设置失败: $e');
    }
  }

  Future<void> setLocaleEnabled(bool value) async {
    try {
      if (!hasLocaleTables.value && value) return;
      localeEnabled.value = value;
      var foxyViewModel = GetIt.instance.get<FoxyViewModel>();
      foxyViewModel.localeEnabled = value;
      await _updateConfig();
    } catch (e) {
      LoggerUtil.instance.e('设置本地化开关失败: $e');
      DialogUtil.instance.error('设置本地化开关失败: $e');
    }
  }

  Future<void> _updateConfig() async {
    try {
      var currentDirectory = Directory.current;
      var path = join(currentDirectory.path, 'config.yaml');
      var file = File(path);
      if (!await file.exists()) return;
      var content = await file.readAsString();
      var yaml = loadYaml(content) as Map;
      var config = Map<String, dynamic>.from(yaml);
      config['locale_enabled'] = localeEnabled.value;
      var editor = YamlEditor('');
      editor.update([], config);
      await file.writeAsString(editor.toString());
    } catch (e) {
      LoggerUtil.instance.e('保存设置失败: $e');
      DialogUtil.instance.error('保存设置失败: $e');
    }
  }
}
