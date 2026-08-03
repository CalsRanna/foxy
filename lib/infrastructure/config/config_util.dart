import 'dart:io';

import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

class ConfigUtil {
  Future<void> _pendingUpdate = Future.value();

  String get configPath => p.join(Directory.current.path, 'config.yaml');

  Future<Map<String, dynamic>> load() async {
    LoggerUtil.instance.d(configPath);
    final file = File(configPath);
    if (!await file.exists()) return {};
    final content = await file.readAsString();
    if (content.trim().isEmpty) return {};
    try {
      final yaml = loadYaml(content);
      if (yaml is! Map) return {};
      return Map<String, dynamic>.from(yaml);
    } on YamlException catch (error) {
      // 配置损坏时自愈:备份损坏文件、按空配置返回,保证加载与保存可继续,
      // 而不是让应用内永远无法恢复。
      LoggerUtil.instance.w('config.yaml 解析失败,已备份为 config.yaml.bak: $error');
      try {
        await file.rename('${file.path}.bak');
      } catch (_) {
        // 备份失败不影响本次按空配置继续。
      }
      return {};
    }
  }

  Future<void> update(Map<String, dynamic> values) {
    final snapshot = Map<String, dynamic>.from(values);
    final operation = _pendingUpdate
        .catchError((Object _) {})
        .then((_) => _performUpdate(snapshot));
    _pendingUpdate = operation;
    return operation;
  }

  Future<void> _performUpdate(Map<String, dynamic> values) async {
    final file = File(configPath);
    if (!await file.exists()) await file.create(recursive: true);
    final config = {...await load(), ...values};
    final editor = YamlEditor('');
    editor.update([], config);
    // 临时文件 + rename 原子替换,避免进程中断留下截断的 config.yaml。
    final temporaryFile = File('$configPath.tmp');
    await temporaryFile.writeAsString(editor.toString());
    await temporaryFile.rename(configPath);
  }
}
