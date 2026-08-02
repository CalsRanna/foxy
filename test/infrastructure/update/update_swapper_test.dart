import 'dart:io';

import 'package:foxy/infrastructure/update/update_swapper.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

/// 应用目录旧版本 + 用户数据;payload 为新版本内容。
void main() {
  late Directory appDir;
  late Directory payloadDir;

  setUp(() {
    final base = Directory.systemTemp.createTempSync('foxy_swap_test_');
    appDir = Directory(p.join(base.path, 'app'))..createSync();
    payloadDir = Directory(p.join(base.path, 'payload'))..createSync();

    // 旧版本文件(应被替换/删除)。
    File(p.join(appDir.path, 'foxy.exe')).writeAsStringSync('old-exe');
    File(p.join(appDir.path, 'data', 'flutter_assets', 'old.png'))
        .createSync(recursive: true);
    File(p.join(appDir.path, 'data', 'icudtl.dat')).writeAsStringSync('old-icu');
    File(p.join(appDir.path, 'stale.dll')).writeAsStringSync('stale');
    Directory(p.join(appDir.path, 'empty_dir')).createSync();

    // 用户数据(必须保留)。
    File(p.join(appDir.path, 'config.yaml')).writeAsStringSync('host: x');
    final icon1 = File(p.join(appDir.path, 'data', 'icon', 'icon1.blp'));
    icon1.parent.createSync(recursive: true);
    icon1.writeAsStringSync('blp1');
    final icon2 = File(p.join(appDir.path, 'data', 'icon', 'icon2.blp'));
    icon2.writeAsStringSync('blp2');

    // 新版本 payload。
    File(p.join(payloadDir.path, 'foxy.exe')).writeAsStringSync('new-exe');
    final asset = File(
      p.join(payloadDir.path, 'data', 'flutter_assets', 'new.png'),
    );
    asset.parent.createSync(recursive: true);
    asset.writeAsStringSync('png');
    File(p.join(payloadDir.path, 'data', 'icudtl.dat'))
        .writeAsStringSync('new-icu');
    File(p.join(payloadDir.path, 'new_file.dll')).writeAsStringSync('new-dll');
  });

  tearDown(() {
    appDir.parent.deleteSync(recursive: true);
  });

  test('镜像替换:新文件覆盖、旧文件删除、用户数据保留', () async {
    final result = await UpdateSwapper.applyUpdate(
      appDir: appDir,
      payloadRoot: payloadDir,
    );

    expect(result.hasFailures, isFalse);
    // 新版本文件已就位。
    expect(File(p.join(appDir.path, 'foxy.exe')).readAsStringSync(), 'new-exe');
    expect(
      File(p.join(appDir.path, 'data', 'flutter_assets', 'new.png'))
          .readAsStringSync(),
      'png',
    );
    expect(
      File(p.join(appDir.path, 'data', 'icudtl.dat')).readAsStringSync(),
      'new-icu',
    );
    expect(
      File(p.join(appDir.path, 'new_file.dll')).readAsStringSync(),
      'new-dll',
    );
    // 旧版本残留被删除。
    expect(File(p.join(appDir.path, 'stale.dll')).existsSync(), isFalse);
    expect(
      File(p.join(appDir.path, 'data', 'flutter_assets', 'old.png'))
          .existsSync(),
      isFalse,
    );
    // 空目录被清理。
    expect(Directory(p.join(appDir.path, 'empty_dir')).existsSync(), isFalse);
    // 用户数据原样保留。
    expect(File(p.join(appDir.path, 'config.yaml')).readAsStringSync(), 'host: x');
    expect(
      File(p.join(appDir.path, 'data', 'icon', 'icon1.blp'))
          .readAsStringSync(),
      'blp1',
    );
    expect(
      File(p.join(appDir.path, 'data', 'icon', 'icon2.blp'))
          .readAsStringSync(),
      'blp2',
    );
  });

  test('isPreserved 命中自身与子树', () {
    expect(UpdateSwapper.isPreserved('config.yaml'), isTrue);
    expect(UpdateSwapper.isPreserved('data/icon'), isTrue);
    expect(UpdateSwapper.isPreserved('data/icon/icon1.blp'), isTrue);
    expect(UpdateSwapper.isPreserved(r'data\icon\icon1.blp'), isTrue);
    expect(UpdateSwapper.isPreserved('data/flutter_assets/a.png'), isFalse);
    expect(UpdateSwapper.isPreserved('foxy.exe'), isFalse);
    expect(UpdateSwapper.isPreserved('data/icon_extra'), isFalse);
  });

  test('单文件失败记录到 failures,不中断整体交换', () async {
    // 锁定一个将被删除的旧文件(Windows 上删除失败)。
    final locked = File(p.join(appDir.path, 'stale.dll'));
    final handle = locked.openSync(mode: FileMode.writeOnlyAppend);
    try {
      final result = await UpdateSwapper.applyUpdate(
        appDir: appDir,
        payloadRoot: payloadDir,
        maxRetries: 1,
      );
      // 新文件仍已就位。
      expect(
        File(p.join(appDir.path, 'foxy.exe')).readAsStringSync(),
        'new-exe',
      );
      // 失败可能记录(锁文件删除失败),也可能因平台允许而成功。
      // 只要交换结果不抛异常、新文件就位即可。
      if (result.hasFailures) {
        expect(result.failures.first.path, locked.path);
      }
    } finally {
      handle.closeSync();
    }
  });

  test('payload 根为 .update_tmp 子目录时,交换后可被完整删除', () async {
    // 模拟:payload 在 .update_tmp/Foxy 下,且 .update_tmp 里有其他残留。
    final updateTemp =
        Directory(p.join(appDir.path, kUpdateTempDirName))..createSync();
    final nested = Directory(p.join(updateTemp.path, 'Foxy'))..createSync();
    File(p.join(nested.path, 'foxy.exe')).writeAsStringSync('nested-exe');
    File(p.join(updateTemp.path, 'junk.bin')).writeAsStringSync('junk');

    final result = await UpdateSwapper.applyUpdate(
      appDir: appDir,
      payloadRoot: nested,
    );
    expect(result.hasFailures, isFalse);
    // 新版本来自嵌套 payload。
    expect(
      File(p.join(appDir.path, 'foxy.exe')).readAsStringSync(),
      'nested-exe',
    );
    // 用户数据仍在。
    expect(File(p.join(appDir.path, 'config.yaml')).existsSync(), isTrue);
    expect(
      Directory(p.join(appDir.path, 'data', 'icon')).existsSync(),
      isTrue,
    );
    // 交换器不触碰 .update_tmp(整目录由辅助程序交换后删除);模拟辅助
    // 程序删除整个临时目录,验证不影响已交换的应用文件。
    updateTemp.deleteSync(recursive: true);
    expect(updateTemp.existsSync(), isFalse);
    expect(
      File(p.join(appDir.path, 'foxy.exe')).readAsStringSync(),
      'nested-exe',
    );
  });
}
