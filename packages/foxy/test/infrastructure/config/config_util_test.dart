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

  test('并发首次加载后复用缓存，调用方可以修改返回的副本', () async {
    final file = await File(configUtil.configPath).writeAsString('host: local');
    final results = await Future.wait([configUtil.load(), configUtil.load()]);

    results.first['host'] = 'modified';
    await file.delete();

    expect(results.last, {'host': 'local'});
    expect(await configUtil.load(), {'host': 'local'});
  });

  test('update 后 load 回读一致', () async {
    final file = await File(configUtil.configPath).writeAsString('host: local');
    await configUtil.load();
    final notifiedTables = ['footstepterrainlookup'];
    await Future.wait([
      configUtil.update({'use_ssl': true}),
      configUtil.update({'notified_tables': notifiedTables}),
    ]);
    notifiedTables.clear();

    final saved = await _TempConfigUtil(tempDir.path).load();
    await file.delete();

    expect(saved, {
      'host': 'local',
      'use_ssl': true,
      'notified_tables': ['footstepterrainlookup'],
    });
    expect(await configUtil.load(), saved);
  });

  test('保存失败时保留缓存，后续保存仍可成功', () async {
    await configUtil.update({'host': 'local'});
    final temporaryDir = await Directory('${configUtil.configPath}.tmp')
        .create();

    await expectLater(
      configUtil.update({'host': 'failed'}),
      throwsA(isA<FileSystemException>()),
    );
    expect(await configUtil.load(), {'host': 'local'});

    await temporaryDir.delete();
    await configUtil.update({'host': 'updated'});
    expect(await configUtil.load(), {'host': 'updated'});
  });

  test('首次读取失败后可以重试', () async {
    final file = await File(configUtil.configPath).writeAsBytes([0xff]);
    await expectLater(configUtil.load(), throwsA(isA<FileSystemException>()));

    await file.writeAsString('host: recovered');
    expect(await configUtil.load(), {'host': 'recovered'});
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
    expect(
      await File('${configUtil.configPath}.bak').readAsString(),
      'just a string',
    );
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
