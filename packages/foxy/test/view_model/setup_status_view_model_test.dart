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
    Directory(p.join(root.path, 'data', 'dbc')).createSync(recursive: true);
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

  test(
    'prepare loads directory settings and the icon extraction flag',
    () async {
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
    },
  );

  test('A missing configured directory counts as unconfigured and preserves the original path', () async {
    final gone = p.join(tempDir.path, '已删除');
    await configUtil.update({'client_dir': gone});

    final vm = buildVm();
    await vm.prepare();

    expect(vm.clientDir.value, gone);
    expect(vm.clientDirExists.value, isFalse);
    expect(vm.isClientDirConfigured, isFalse);
    expect(vm.isSetupComplete, isFalse);
  });

  test(
    'saveClientDir rejects a missing directory and sets the error signal',
    () async {
      final vm = buildVm();
      final ok = await vm.saveClientDir(p.join(tempDir.path, '不存在'));

      expect(ok, isFalse);
      expect(vm.clientDirError.value, contains('不存在'));
      expect(vm.isClientDirConfigured, isFalse);
    },
  );

  test('saveClientDir rejects an empty path and shows an error', () async {
    final vm = buildVm();
    expect(await vm.saveClientDir('   '), isFalse);
    expect(vm.clientDirError.value, contains('客户端目录'));
  });

  test(
    'saveClientDir persists client_dir and detects and stores mpq_dir',
    () async {
      final client = Directory(p.join(tempDir.path, 'client'))..createSync();
      final mpq = p.join(client.path, 'Data', 'zhCN');
      final vm = buildVm(
        findMpqDir: (root) => root == client.path ? mpq : null,
      );

      expect(await vm.saveClientDir(client.path), isTrue);
      expect(vm.clientDir.value, client.path);
      expect(vm.clientDirExists.value, isTrue);
      expect(vm.mpqDir.value, mpq);

      final config = await configUtil.load();
      expect(config['client_dir'], client.path);
      expect(config['mpq_dir'], mpq);
    },
  );

  test('saveClientDir fails and sets the error signal when it cannot find MPQ files', () async {
    final client = Directory(p.join(tempDir.path, 'client'))..createSync();
    await configUtil.update({'mpq_dir': p.join('旧', 'mpq')});
    final vm = buildVm();

    expect(await vm.saveClientDir(client.path), isFalse);
    expect(vm.clientDirError.value, contains('未找到 MPQ'));
    expect(vm.isClientDirConfigured, isFalse);
    // Nothing is persisted, so the stale mpq_dir is left untouched instead
    // of being emptied into a half-configured state.
    final config = await configUtil.load();
    expect(config['client_dir'], isNull);
    expect(config['mpq_dir'], p.join('旧', 'mpq'));
  });

  test(
    'saveServerDir validates and persists server_dir and the detected dbc_dir',
    () async {
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
    },
  );

  test('saveServerDir fails and sets the error signal when it cannot find DBC files', () async {
    final server = Directory(p.join(tempDir.path, 'server'))..createSync();
    final vm = buildVm(findDbcDir: (_) async => null);

    expect(await vm.saveServerDir(server.path), isFalse);
    expect(vm.serverDirError.value, contains('未找到 DBC'));
    expect(vm.isServerDirConfigured, isFalse);
    expect((await configUtil.load())['server_dir'], isNull);
  });

  test(
    'saveServerDir rejects a missing directory and sets the error signal',
    () async {
      final vm = buildVm();
      expect(await vm.saveServerDir(p.join(tempDir.path, '不存在')), isFalse);
      expect(vm.serverDirError.value, contains('不存在'));
    },
  );

  test(
    'prepare reads dbc_dir and treats legacy dbc_path as unconfigured',
    () async {
      final oldDbc = Directory(p.join(tempDir.path, 'old'))..createSync();
      await configUtil.update({'dbc_path': oldDbc.path});

      final vm = buildVm();
      await vm.prepare();

      expect(vm.dbcPath.value, isNull);
      // An unset directory needs no repair, consistent with clientDirExists.
      expect(vm.dbcPathExists.value, isTrue);
      expect(vm.isServerDirConfigured, isFalse);
      expect(vm.isSetupComplete, isFalse);
    },
  );

  test('isSetupComplete requires every step to finish', () async {
    final client = Directory(p.join(tempDir.path, 'client'))..createSync();
    final server = buildServerRoot();
    final vm = buildVm(findMpqDir: (_) => p.join(client.path, 'Data', 'zhCN'));

    await vm.saveClientDir(client.path);
    expect(vm.isSetupComplete, isFalse); // server directory missing

    await vm.saveServerDir(server.path);
    expect(vm.isSetupComplete, isFalse); // icon-extraction marker missing

    await configUtil.update({'icons_extracted': true});
    await vm.prepare();
    expect(vm.isSetupComplete, isTrue);
  });

  test('skipClientSetup persists the choice to skip client setup', () async {
    final client = Directory(p.join(tempDir.path, 'client'))..createSync();
    final server = buildServerRoot();
    String? findMpq(String root) => p.join(root, 'Data', 'zhCN');
    final vm = buildVm(findMpqDir: findMpq);

    await vm.saveClientDir(client.path);
    await vm.saveServerDir(server.path);
    expect(vm.isSetupComplete, isFalse); // icon-extraction marker missing

    await vm.skipClientSetup();
    expect(vm.clientSetupSkipped.value, isTrue);
    expect(vm.isSetupComplete, isTrue);

    final freshConfig = _TempConfigUtil(tempDir.path);
    expect((await freshConfig.load())['client_setup_skipped'], isTrue);
    final reloaded = SetupStatusViewModel(configUtil: freshConfig);
    await reloaded.prepare();
    expect(reloaded.clientSetupSkipped.value, isTrue);
    expect(reloaded.isSetupComplete, isTrue);
  });

  test(
    'Client setup is complete without a client directory after skipping',
    () async {
      final server = buildServerRoot();
      final vm = buildVm();

      await vm.saveServerDir(server.path);
      expect(vm.isSetupComplete, isFalse);

      await vm.skipClientSetup();
      expect(vm.isClientDirConfigured, isFalse);
      expect(vm.isSetupComplete, isTrue);
    },
  );

  test('Skipping the server directory survives restart and configuring it clears the skipped state', () async {
    final vm = buildVm();
    await vm.skipClientSetup();
    await vm.skipServerSetup();

    final reloaded = SetupStatusViewModel(
      configUtil: _TempConfigUtil(tempDir.path),
    );
    await reloaded.prepare();
    expect(reloaded.isSetupComplete, isTrue);
    expect(reloaded.serverSetupSkipped.value, isTrue);
    expect(reloaded.isDbcPathConfigured, isFalse);

    final server = buildServerRoot();
    expect(await reloaded.saveServerDir(server.path), isTrue);
    expect(reloaded.serverSetupSkipped.value, isFalse);
    expect(reloaded.isDbcPathConfigured, isTrue);
    expect(
      (await _TempConfigUtil(tempDir.path).load())['server_setup_skipped'],
      isFalse,
    );
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
