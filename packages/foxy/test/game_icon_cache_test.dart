import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_cache.dart';
import 'package:path/path.dart' as p;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('foxy_icon_cache_test_');
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  test('加载 BLP 返回正确尺寸的 ui.Image', () async {
    final cache = GameIconCache();
    final image = await cache.load(
      File('test/fixture/icons/fixture_dxt1.blp').absolute.path,
    );
    expect(image, isNotNull);
    expect(image!.width, 64);
    expect(image.height, 64);
  });

  test('重复加载命中缓存（返回独立克隆）', () async {
    final cache = GameIconCache();
    final path = File('test/fixture/icons/fixture_dxt1.blp').absolute.path;
    final first = await cache.load(path);
    expect(cache.contains(path), isTrue);
    final second = await cache.load(path);
    expect(second, isNotNull);
    // 每次 load 返回调用方自有的克隆:释放任一份不影响另一份。
    expect(identical(first, second), isFalse);
    first!.dispose();
    expect(second!.width, 64);
    expect(second.height, 64);
    second.dispose();
  });

  test('驱逐原件不影响已借出的克隆', () async {
    final cache = GameIconCache(maxEntries: 2);
    final dir = Directory(p.join(tempDir.path, 'icons'))..createSync();
    for (final name in ['a', 'b', 'c']) {
      File('test/fixture/icons/fixture_dxt1.blp').copySync(
        p.join(dir.path, '$name.blp'),
      );
    }
    // 借出 a 的克隆,再加载 b、c 把 a 的原件挤出缓存并销毁。
    final borrowed = await cache.load(p.join(dir.path, 'a.blp'));
    expect(borrowed, isNotNull);
    await cache.load(p.join(dir.path, 'b.blp'));
    await cache.load(p.join(dir.path, 'c.blp'));
    expect(cache.contains(p.join(dir.path, 'a.blp')), isFalse);
    // 克隆的底层像素由引用计数保活,驱逐后仍可用、可绘制。
    expect(borrowed!.width, 64);
    expect(borrowed.height, 64);
    borrowed.dispose();
  });

  test('文件缺失返回 null', () async {
    final cache = GameIconCache();
    expect(await cache.load(p.join(tempDir.path, 'missing.blp')), isNull);
  });

  test('损坏文件返回 null（不抛异常）', () async {
    final cache = GameIconCache();
    final broken = File(p.join(tempDir.path, 'broken.blp'));
    broken.writeAsBytesSync(List.filled(128, 0));
    expect(await cache.load(broken.path), isNull);
  });

  test('LRU 超限淘汰最久未用条目，淘汰后可重新加载', () async {
    final cache = GameIconCache(maxEntries: 2);
    final dir = Directory(p.join(tempDir.path, 'icons'))..createSync();
    // Copy the same BLP 3 times (identical decode content does not affect
    // cache keys).
    for (final name in ['a', 'b', 'c']) {
      File('test/fixture/icons/fixture_dxt1.blp').copySync(
        p.join(dir.path, '$name.blp'),
      );
    }
    final a = await cache.load(p.join(dir.path, 'a.blp'));
    expect(a, isNotNull);
    await cache.load(p.join(dir.path, 'b.blp'));
    await cache.load(p.join(dir.path, 'c.blp'));
    expect(cache.contains(p.join(dir.path, 'a.blp')), isFalse, reason: 'a 被淘汰');
    expect(cache.contains(p.join(dir.path, 'b.blp')), isTrue);
    expect(cache.contains(p.join(dir.path, 'c.blp')), isTrue);

    // Touch b again to promote it, then evict c.
    await cache.load(p.join(dir.path, 'b.blp'));
    await cache.load(p.join(dir.path, 'a.blp'));
    expect(cache.contains(p.join(dir.path, 'c.blp')), isFalse, reason: 'c 被淘汰');
    // After eviction the file can be reloaded (still on disk).
    final reloaded = await cache.load(p.join(dir.path, 'a.blp'));
    expect(reloaded, isNotNull);
  });

  test('clear 释放并清空缓存', () async {
    final cache = GameIconCache();
    final path = File('test/fixture/icons/fixture_dxt1.blp').absolute.path;
    (await cache.load(path))?.dispose();
    cache.clear();
    expect(cache.contains(path), isFalse);
    // 清空后重新加载仍可从磁盘解码。
    final reloaded = await cache.load(path);
    expect(reloaded, isNotNull);
    reloaded!.dispose();
  });
}
