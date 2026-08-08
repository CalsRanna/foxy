import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/game_asset/blp_icon_provider.dart';
import 'package:path/path.dart' as p;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late String fixtureBlp;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('foxy_blp_provider_test_');
    fixtureBlp = File('test/fixture/icons/fixture_dxt1.blp').absolute.path;
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  group('BlpIconCache', () {
    test('超限驱逐最久未记录项', () {
      final cache = BlpIconCache(maxEntries: 3);
      cache.add('a');
      cache.add('b');
      cache.add('c');
      cache.add('d');
      expect(cache.contains('a'), isFalse, reason: 'a 是最旧的,被驱逐');
      expect(cache.contains('b'), isTrue);
      expect(cache.contains('c'), isTrue);
      expect(cache.contains('d'), isTrue);
    });

    test('命中提升 LRU 位置', () {
      final cache = BlpIconCache(maxEntries: 3);
      cache.add('a');
      cache.add('b');
      cache.add('c');
      expect(cache.contains('a'), isTrue, reason: '命中 a 将其提升');
      cache.add('d');
      expect(cache.contains('a'), isTrue, reason: 'a 被提升后保住');
      expect(cache.contains('b'), isFalse, reason: 'b 成为最旧,被驱逐');
    });

    test('clear 清空后重新记录', () {
      final cache = BlpIconCache();
      cache.add('a');
      cache.clear();
      expect(cache.contains('a'), isFalse);
      cache.add('a');
      expect(cache.contains('a'), isTrue);
    });
  });

  group('BlpIconProvider', () {
    test('obtainKey 归一化 rawPath', () async {
      final provider = BlpIconProvider(rawPath: 'Interface\\Icons\\INV_Misc_Foo');
      final key = await provider.obtainKey(const ImageConfiguration());
      expect(key.name, 'inv_misc_foo');
    });

    test('provider 相等性基于 rawPath', () {
      expect(
        BlpIconProvider(rawPath: 'a') == BlpIconProvider(rawPath: 'a'),
        isTrue,
      );
      expect(
        BlpIconProvider(rawPath: 'a') == BlpIconProvider(rawPath: 'b'),
        isFalse,
      );
    });

    test('加载成功返回 64×64 图像', () async {
      final cache = BlpIconCache();
      final provider = BlpIconProvider(
        rawPath: 'fixture_dxt1',
        negativeCache: cache,
        iconDir: p.dirname(fixtureBlp),
      );
      final info = await loadViaStream(provider);
      expect(info, isNotNull);
      expect(info!.image.width, 64);
      expect(info.image.height, 64);
      info.dispose();
    });

    test('文件缺失抛错并记录负缓存', () async {
      final cache = BlpIconCache();
      final provider = BlpIconProvider(
        rawPath: 'no_such_icon',
        negativeCache: cache,
        iconDir: p.dirname(fixtureBlp),
      );
      expect(await loadViaStream(provider), isNull);
      expect(cache.contains('no_such_icon'), isTrue);
    });

    test('损坏 BLP 抛错并记录负缓存', () async {
      File(p.join(tempDir.path, 'broken.blp'))
          .writeAsBytesSync(List.filled(128, 0));
      final cache = BlpIconCache();
      final provider = BlpIconProvider(
        rawPath: 'broken',
        negativeCache: cache,
        iconDir: tempDir.path,
      );
      expect(await loadViaStream(provider), isNull);
      expect(cache.contains('broken'), isTrue);
    });

    test('负缓存命中直接失败,不访问文件系统', () async {
      // 即使文件真实存在,负缓存命中也必须短路(模拟提取前记录的缺失)。
      final cache = BlpIconCache()..add('fixture_dxt1');
      final provider = BlpIconProvider(
        rawPath: 'fixture_dxt1',
        negativeCache: cache,
        iconDir: p.dirname(fixtureBlp),
      );
      expect(await loadViaStream(provider), isNull,
          reason: '负缓存命中直接抛错,不读文件');
    });
  });
}

/// 通过 ImageStream 加载,返回 ImageInfo 或 null(失败)。
Future<ImageInfo?> loadViaStream(BlpIconProvider provider) async {
  final key = await provider.obtainKey(const ImageConfiguration());
  final completer = Completer<ImageInfo?>();
  final stream = provider.loadImage(key, _dummyDecode);
  stream.addListener(
    ImageStreamListener(
      (info, synchronousCall) {
        if (!completer.isCompleted) completer.complete(info);
      },
      onError: (error, stackTrace) {
        if (!completer.isCompleted) completer.complete(null);
      },
    ),
  );
  return completer.future;
}

/// BlpIconProvider 用 decodeImageFromPixels 自行解码,不触发该回调。
Future<ui.Codec> _dummyDecode(
  ui.ImmutableBuffer buffer, {
  ui.TargetImageSizeCallback? getTargetSize,
}) {
  throw StateError('decode callback should not be used by BlpIconProvider');
}
