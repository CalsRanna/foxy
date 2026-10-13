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

  group('BlpIconProvider', () {
    test('obtainKey 归一化 rawPath', () async {
      final provider = BlpIconProvider(
        rawPath: 'Interface\\Icons\\INV_Misc_Foo',
      );
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
      final provider = BlpIconProvider(
        rawPath: 'fixture_dxt1',
        iconDir: p.dirname(fixtureBlp),
      );
      final info = await loadViaStream(provider);
      expect(info, isNotNull);
      expect(info!.image.width, 64);
      expect(info.image.height, 64);
      info.dispose();
    });

    test('文件缺失抛错,失败的 key 从 ImageCache 驱逐', () async {
      PaintingBinding.instance.imageCache.clear();
      final provider = BlpIconProvider(
        rawPath: 'no_such_icon',
        iconDir: p.dirname(fixtureBlp),
      );
      expect(await resolveViaStream(provider), isNull);
      final key = await provider.obtainKey(const ImageConfiguration());
      expect(
        PaintingBinding.instance.imageCache.statusForKey(key).untracked,
        isTrue,
        reason: '失败的 key 不残留(否则会卡住后续重试)',
      );
    });

    test('损坏 BLP 抛错,失败的 key 从 ImageCache 驱逐', () async {
      PaintingBinding.instance.imageCache.clear();
      File(
        p.join(tempDir.path, 'broken.blp'),
      ).writeAsBytesSync(List.filled(128, 0));
      final provider = BlpIconProvider(
        rawPath: 'broken',
        iconDir: tempDir.path,
      );
      expect(await resolveViaStream(provider), isNull);
      final key = await provider.obtainKey(const ImageConfiguration());
      expect(
        PaintingBinding.instance.imageCache.statusForKey(key).untracked,
        isTrue,
      );
    });

    test('失败后文件出现,同一 key 可重新加载', () async {
      PaintingBinding.instance.imageCache.clear();
      // 先失败(文件不存在),此后再把文件放到位并重新 resolve:必须能加载成功,
      // 证明失败的加载没有卡住该 key(自 evict 的意义)。
      final provider = BlpIconProvider(
        rawPath: 'late_icon',
        iconDir: tempDir.path,
      );
      expect(await resolveViaStream(provider), isNull);

      File(
        p.join(tempDir.path, 'late_icon.blp'),
      ).writeAsBytesSync(File(fixtureBlp).readAsBytesSync());
      final info = await resolveViaStream(provider);
      expect(info, isNotNull);
      info!.dispose();
    });
  });
}

/// 通过 [ImageStream] 加载,返回 [ImageInfo] 或 null(失败)。
Future<ImageInfo?> loadViaStream(BlpIconProvider provider) async {
  final key = await provider.obtainKey(const ImageConfiguration());
  final stream = ImageStream()..setCompleter(provider.loadImage(key, _dummyDecode));
  return _listen(stream);
}

/// 通过 [ImageProvider.resolve] 加载(经由 ImageCache),返回 [ImageInfo] 或 null。
Future<ImageInfo?> resolveViaStream(BlpIconProvider provider) async {
  final stream = provider.resolve(const ImageConfiguration());
  return _listen(stream);
}

Future<ImageInfo?> _listen(ImageStream stream) {
  final completer = Completer<ImageInfo?>();
  late ImageStreamListener listener;
  listener = ImageStreamListener(
    (info, synchronousCall) {
      if (!completer.isCompleted) completer.complete(info);
      stream.removeListener(listener);
    },
    onError: (error, stackTrace) {
      if (!completer.isCompleted) completer.complete(null);
      stream.removeListener(listener);
    },
  );
  stream.addListener(listener);
  return completer.future;
}

/// BlpIconProvider 用 decodeImageFromPixels 自行解码,不触发该回调。
Future<ui.Codec> _dummyDecode(
  ui.ImmutableBuffer buffer, {
  ui.TargetImageSizeCallback? getTargetSize,
}) {
  throw StateError('decode callback should not be used by BlpIconProvider');
}
