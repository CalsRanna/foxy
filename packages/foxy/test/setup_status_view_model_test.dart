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

  /// Server root with a standard `data/dbc` layout holding one .dbc file.
  Directory buildServerRoot() {
    final root = Directory(p.join(tempDir.path, 'server'))..createSync();
    Directory(p.join(root.path, 'data', 'dbc'))
        .createSync(recursive: true);
    File(p.join(root.path, 'data', 'dbc', 'Spell.dbc')).createSync();
    return root;
  }

  SetupStatusViewModel buildVm({
    Future<String?> Function(String)? findDbcDir,
    String? Function(String)? findMpqDir,
  }) => SetupStatusViewModel(
    configUtil: configUtil,
    findDbcDir: findDbcDir ?? (root) async => p.join(root, 'data', 'dbc'),
    findMpqDir: findMpqDir ?? (_) => null,
  );

  test('prepare 加载目录配置与图标提取标记', () async {
    final client = Directory(p.join(tempDir.path, 'client'))..createSync();
    final server = buildServerRoot();
    await configUtil.update({
      'client_dir': client.path,
      'server_dir': server.path,
      'dbc_dir': p.join(server.path, 'data', 'dbc'),
      'icons_extracted': true,
    });

    final vm = buildVm();
    await vm.prepare();

    expect(vm.clientDir.value, client.path);
    expect(vm.clientDirExists.value, isTrue);
    expect(vm.serverDir.value, server.path);
    expect(vm.serverDirExists.value, isTrue);
    expect(vm.dbcPath.value, p.join(server.path, 'data', 'dbc'));
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

  test('saveClientDir 持久化 client_dir 并自动探测写入 mpq_dir', () async {
    final client = Directory(p.join(tempDir.path, 'client'))..createSync();
    final mpq = p.join(client.path, 'Data', 'zhCN');
    final vm = buildVm(findMpqDir: (root) => root == client.path ? mpq : null);

    expect(await vm.saveClientDir(client.path), isTrue);
    expect(vm.clientDir.value, client.path);
    expect(vm.clientDirExists.value, isTrue);
    expect(vm.mpqDir.value, mpq);

    final config = await configUtil.load();
    expect(config['client_dir'], client.path);
    expect(config['mpq_dir'], mpq);
  });

  test('saveClientDir 探测不到 MPQ 时写入空串避免旧值残留', () async {
    final client = Directory(p.join(tempDir.path, 'client'))..createSync();
    await configUtil.update({'mpq_dir': p.join('旧', 'mpq')});
    final vm = buildVm();

    expect(await vm.saveClientDir(client.path), isTrue);
    expect(vm.mpqDir.value, isNull);
    expect((await configUtil.load())['mpq_dir'], '');
  });

  test('saveServerDir 校验并持久化 server_dir 与探测出的 dbc_dir', () async {
    final server = buildServerRoot();
    final vm = buildVm();

    expect(await vm.saveServerDir(server.path), isTrue);
    expect(vm.serverDir.value, server.path);
    expect(vm.serverDirExists.value, isTrue);
    expect(vm.serverDirError.value, isNull);
    expect(vm.dbcPath.value, p.join(server.path, 'data', 'dbc'));
    expect(vm.dbcPathExists.value, isTrue);

    final config = await configUtil.load();
    expect(config['server_dir'], server.path);
    expect(config['dbc_dir'], p.join(server.path, 'data', 'dbc'));
  });

  test('saveServerDir 探测不到 DBC 时失败并写入错误信号', () async {
    final server = Directory(p.join(tempDir.path, 'server'))..createSync();
    final vm = buildVm(findDbcDir: (_) async => null);

    expect(await vm.saveServerDir(server.path), isFalse);
    expect(vm.serverDirError.value, contains('未找到 DBC'));
    expect(vm.isServerDirConfigured, isFalse);
    expect((await configUtil.load())['server_dir'], isNull);
  });

  test('saveServerDir 目录不存在时失败并写入错误信号', () async {
    final vm = buildVm();
    expect(await vm.saveServerDir(p.join(tempDir.path, '不存在')), isFalse);
    expect(vm.serverDirError.value, contains('不存在'));
  });

  test('prepare 仅读 dbc_dir,旧 dbc_path 视为未配置', () async {
    final oldDbc = Directory(p.join(tempDir.path, 'old'))..createSync();
    await configUtil.update({'dbc_path': oldDbc.path});

    final vm = buildVm();
    await vm.prepare();

    expect(vm.dbcPath.value, isNull);
    // 未配置时 *Exists 视为无需修复(true),与 clientDirExists 语义一致。
    expect(vm.dbcPathExists.value, isTrue);
    expect(vm.isServerDirConfigured, isFalse);
    expect(vm.isSetupComplete, isFalse);
  });

  test('isSetupComplete 需要全部步骤完成', () async {
    final client = Directory(p.join(tempDir.path, 'client'))..createSync();
    final server = buildServerRoot();
    final vm = buildVm();

    await vm.saveClientDir(client.path);
    expect(vm.isSetupComplete, isFalse); // server directory missing

    await vm.saveServerDir(server.path);
    expect(vm.isSetupComplete, isFalse); // icon-extraction marker missing

    await configUtil.update({'icons_extracted': true});
    await vm.prepare();
    expect(vm.isSetupComplete, isTrue);
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
