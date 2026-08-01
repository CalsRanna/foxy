import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/view_model/setup_status_view_model.dart';
import 'package:path/path.dart' as p;

void main() {
  late Directory tempDir;
  late _TempConfigUtil configUtil;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('foxy_setup_vm_test_');
    configUtil = _TempConfigUtil(tempDir.path);
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  SetupStatusViewModel buildVm() => SetupStatusViewModel(configUtil: configUtil);

  test('prepare 加载目录配置与图标提取标记', () async {
    final client = Directory(p.join(tempDir.path, 'client'))..createSync();
    final dbc = Directory(p.join(tempDir.path, 'dbc'))..createSync();
    await configUtil.update({
      'client_dir': client.path,
      'dbc_path': dbc.path,
      'icons_extracted': true,
    });

    final vm = buildVm();
    await vm.prepare();

    expect(vm.clientDir.value, client.path);
    expect(vm.clientDirExists.value, isTrue);
    expect(vm.dbcPath.value, dbc.path);
    expect(vm.dbcPathExists.value, isTrue);
    expect(vm.iconsExtracted.value, isTrue);
    expect(vm.isSetupComplete, isTrue);
  });

  test('配置了但目录已不存在 → 视为未配置并保留原始路径', () async {
    final gone = p.join(tempDir.path, '已删除');
    await configUtil.update({'client_dir': gone});

    final vm = buildVm();
    await vm.prepare();

    expect(vm.clientDir.value, gone);
    expect(vm.clientDirExists.value, isFalse);
    expect(vm.isClientDirConfigured, isFalse);
    expect(vm.isSetupComplete, isFalse);
  });

  test('saveClientDir 目录不存在时失败并写入错误信号', () async {
    final vm = buildVm();
    final ok = await vm.saveClientDir(p.join(tempDir.path, '不存在'));

    expect(ok, isFalse);
    expect(vm.clientDirError.value, contains('不存在'));
    expect(vm.isClientDirConfigured, isFalse);
  });

  test('saveClientDir 空路径失败并提示', () async {
    final vm = buildVm();
    expect(await vm.saveClientDir('   '), isFalse);
    expect(vm.clientDirError.value, contains('客户端目录'));
  });

  test('saveDbcPath 校验并持久化到 config', () async {
    final dir = Directory(p.join(tempDir.path, 'dbc'))..createSync();
    final vm = buildVm();

    expect(await vm.saveDbcPath(dir.path), isTrue);
    expect(vm.dbcPath.value, dir.path);
    expect(vm.dbcPathExists.value, isTrue);
    expect(vm.dbcPathError.value, isNull);

    final config = await configUtil.load();
    expect(config['dbc_path'], dir.path);
  });

  test('isSetupComplete 需要全部步骤完成', () async {
    final dir = Directory(p.join(tempDir.path, 'd'))..createSync();
    final vm = buildVm();

    await vm.saveClientDir(dir.path);
    expect(vm.isSetupComplete, isFalse); // 缺服务端 DBC 目录

    await vm.saveDbcPath(dir.path);
    expect(vm.isSetupComplete, isFalse); // 缺图标提取标记

    await configUtil.update({'icons_extracted': true});
    await vm.prepare();
    expect(vm.isSetupComplete, isTrue);
  });
}

/// 指向临时目录的 ConfigUtil（避免测试污染项目根目录 config.yaml）。
final class _TempConfigUtil extends ConfigUtil {
  final String _dir;

  _TempConfigUtil(this._dir);

  @override
  String get configPath => p.join(_dir, 'config.yaml');
}
