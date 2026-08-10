import 'dart:io';

import 'package:foxy/infrastructure/update/update_swapper.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

/// App directory with the old version + user data; payload is the new
/// version's content.
void main() {
  late Directory appDir;
  late Directory payloadDir;

  setUp(() {
    final base = Directory.systemTemp.createTempSync('foxy_swap_test_');
    appDir = Directory(p.join(base.path, 'app'))..createSync();
    payloadDir = Directory(p.join(base.path, 'payload'))..createSync();

    // Old-version files (to be replaced/deleted).
    File(p.join(appDir.path, 'foxy.exe')).writeAsStringSync('old-exe');
    File(p.join(appDir.path, 'data', 'flutter_assets', 'old.png'))
        .createSync(recursive: true);
    File(p.join(appDir.path, 'data', 'icudtl.dat')).writeAsStringSync('old-icu');
    File(p.join(appDir.path, 'stale.dll')).writeAsStringSync('stale');
    Directory(p.join(appDir.path, 'empty_dir')).createSync();

    // User data (must be preserved).
    File(p.join(appDir.path, 'config.yaml')).writeAsStringSync('host: x');
    final icon1 = File(p.join(appDir.path, 'data', 'icon', 'icon1.blp'));
    icon1.parent.createSync(recursive: true);
    icon1.writeAsStringSync('blp1');
    final icon2 = File(p.join(appDir.path, 'data', 'icon', 'icon2.blp'));
    icon2.writeAsStringSync('blp2');

    // New-version payload.
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
    // New-version files are in place.
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
    // Old-version leftovers are deleted.
    expect(File(p.join(appDir.path, 'stale.dll')).existsSync(), isFalse);
    expect(
      File(p.join(appDir.path, 'data', 'flutter_assets', 'old.png'))
          .existsSync(),
      isFalse,
    );
    // Empty directories are cleaned up.
    expect(Directory(p.join(appDir.path, 'empty_dir')).existsSync(), isFalse);
    // User data is preserved as-is.
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
    // Lock an old file slated for deletion (deletion fails on Windows).
    final locked = File(p.join(appDir.path, 'stale.dll'));
    final handle = locked.openSync(mode: FileMode.writeOnlyAppend);
    try {
      final result = await UpdateSwapper.applyUpdate(
        appDir: appDir,
        payloadRoot: payloadDir,
        maxRetries: 1,
      );
      // The new file is still in place.
      expect(
        File(p.join(appDir.path, 'foxy.exe')).readAsStringSync(),
        'new-exe',
      );
      // A failure may be recorded (locked-file deletion), or the platform
      // may allow deletion and succeed. Either way, the swap must not
      // throw and the new file must be in place.
      if (result.hasFailures) {
        expect(result.failures.first.path, locked.path);
      }
    } finally {
      handle.closeSync();
    }
  });

  test('payload 根为 .update_tmp 子目录时,交换后可被完整删除', () async {
    // Simulate: payload under .update_tmp/Foxy, with other leftovers in
    // .update_tmp.
    final updateTemp =
        Directory(p.join(appDir.path, UpdateSwapper.tempDirName))..createSync();
    final nested = Directory(p.join(updateTemp.path, 'Foxy'))..createSync();
    File(p.join(nested.path, 'foxy.exe')).writeAsStringSync('nested-exe');
    File(p.join(updateTemp.path, 'junk.bin')).writeAsStringSync('junk');

    final result = await UpdateSwapper.applyUpdate(
      appDir: appDir,
      payloadRoot: nested,
    );
    expect(result.hasFailures, isFalse);
    // The new version comes from a nested payload.
    expect(
      File(p.join(appDir.path, 'foxy.exe')).readAsStringSync(),
      'nested-exe',
    );
    // User data is still there.
    expect(File(p.join(appDir.path, 'config.yaml')).existsSync(), isTrue);
    expect(
      Directory(p.join(appDir.path, 'data', 'icon')).existsSync(),
      isTrue,
    );
    // The swapper never touches .update_tmp (the helper deletes the whole
    // directory after swapping); simulate the helper deleting the temp
    // directory and verify the swapped app files are unaffected.
    updateTemp.deleteSync(recursive: true);
    expect(updateTemp.existsSync(), isFalse);
    expect(
      File(p.join(appDir.path, 'foxy.exe')).readAsStringSync(),
      'nested-exe',
    );
  });
}
