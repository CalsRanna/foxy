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
      if (yaml is! Map) {
        // Parseable YAML of the wrong shape (scalar/list): the file is not
        // usable as a config, and update() would otherwise merge onto an
        // empty map and overwrite the original content forever — back it up
        // like the unparseable case.
        return await _backupCorruptFile(
          file,
          'config.yaml 顶层不是配置映射,已备份为 config.yaml.bak',
        );
      }
      return Map<String, dynamic>.from(yaml);
    } on YamlException catch (error) {
      return _backupCorruptFile(
        file,
        'config.yaml 解析失败,已备份为 config.yaml.bak: $error',
      );
    }
  }

  /// Self-heal on corrupted config: back up the broken file and return an
  /// empty config, so loading and saving keep working instead of the app
  /// being permanently unrecoverable.
  Future<Map<String, dynamic>> _backupCorruptFile(File file, String log) async {
    LoggerUtil.instance.w(log);
    try {
      await file.rename('${file.path}.bak');
    } catch (_) {
      // A failed backup does not block continuing with an empty config
      // this time.
    }
    return {};
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
    // Temp file + rename atomic replacement, so an interrupted process never
    // leaves a truncated config.yaml.
    final temporaryFile = File('$configPath.tmp');
    await temporaryFile.writeAsString(editor.toString());
    await temporaryFile.rename(configPath);
  }
}
