import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

class ConfigUtil {
  Future<void> _pendingUpdate = Future.value();

  String get configPath => p.join(Directory.current.path, 'config.yaml');

  Future<Map<String, dynamic>> load() async {
    final file = File(configPath);
    if (!await file.exists()) return {};
    final content = await file.readAsString();
    if (content.trim().isEmpty) return {};
    final yaml = loadYaml(content);
    if (yaml is! Map) return {};
    return Map<String, dynamic>.from(yaml);
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
    await file.writeAsString(editor.toString());
  }
}
