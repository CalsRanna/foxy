import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:path/path.dart' as p;

void main() {
  late Directory tempDir;
  late _TempConfigUtil configUtil;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('foxy_config_util_test_');
    configUtil = _TempConfigUtil(tempDir.path);
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  test('不存在的配置文件返回空配置', () async {
    expect(await configUtil.load(), isEmpty);
  });

  test('update 后 load 回读一致', () async {
    await configUtil.update({'host': '192.168.1.10', 'use_ssl': true});
    final loaded = await configUtil.load();
    expect(loaded['host'], '192.168.1.10');
    expect(loaded['use_ssl'], true);
  });

  test('损坏的 YAML 自愈:返回空配置并备份 .bak', () async {
    final file = File(configUtil.configPath);
    await file.writeAsString('host: [unclosed\n  broken: yaml: :');

    final loaded = await configUtil.load();

    expect(loaded, isEmpty);
    expect(await File('${configUtil.configPath}.bak').exists(), isTrue);
    // After self-healing, saving still works (the app recovers).
    await configUtil.update({'host': '127.0.0.1'});
    expect((await configUtil.load())['host'], '127.0.0.1');
  });

  test('非 Map 的顶层 YAML(如纯字符串)自愈:返回空配置并备份 .bak', () async {
    final file = File(configUtil.configPath);
    await file.writeAsString('just a string');

    final loaded = await configUtil.load();

    expect(loaded, isEmpty);
    expect(await File('${configUtil.configPath}.bak').exists(), isTrue);
    // The backup preserves the original content; saving still works and
    // never overwrites the backed-up data.
    expect(await File('${configUtil.configPath}.bak').readAsString(), 'just a string');
    await configUtil.update({'host': '127.0.0.1'});
    expect((await configUtil.load())['host'], '127.0.0.1');
  });
}

/// ConfigUtil pointing at a temp directory (so tests never pollute the
/// project-root config.yaml).
final class _TempConfigUtil extends ConfigUtil {
  final String _dir;

  _TempConfigUtil(this._dir);

  @override
  String get configPath => p.join(_dir, 'config.yaml');
}
