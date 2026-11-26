import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy_widget/foxy_widget.dart';
import 'package:path/path.dart' as p;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late String fixtureBlp;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('foxy_blp_provider_test_');
    fixtureBlp = File('test/fixture/icons/foxy_fixture_dxt1.blp').absolute.path;
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  group('FoxyBlpIconProvider', () {
    test('obtainKey normalizes rawPath', () async {
      final provider = FoxyBlpIconProvider(
        rawPath: 'Interface\\Icons\\INV_Misc_Foo',
      );
      final key = await provider.obtainKey(const ImageConfiguration());
      expect(key.name, 'inv_misc_foo');
    });

    test('Provider equality depends on rawPath', () {
      expect(
        FoxyBlpIconProvider(rawPath: 'a') == FoxyBlpIconProvider(rawPath: 'a'),
        isTrue,
      );
      expect(
        FoxyBlpIconProvider(rawPath: 'a') == FoxyBlpIconProvider(rawPath: 'b'),
        isFalse,
      );
    });

    test('Successful loading returns a 64 by 64 image', () async {
      final provider = FoxyBlpIconProvider(
        rawPath: 'foxy_fixture_dxt1',
        iconDir: p.dirname(fixtureBlp),
      );
      final info = await loadViaStream(provider);
      expect(info, isNotNull);
      expect(info!.image.width, 64);
      expect(info.image.height, 64);
      info.dispose();
    });

    test(
      'A missing file throws and evicts the failed key from ImageCache',
      () async {
        PaintingBinding.instance.imageCache.clear();
        final provider = FoxyBlpIconProvider(
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
      },
    );

    test(
      'A corrupt BLP throws and evicts the failed key from ImageCache',
      () async {
        PaintingBinding.instance.imageCache.clear();
        File(p.join(tempDir.path, 'broken.blp'))
            .writeAsBytesSync(List.filled(128, 0));
        final provider = FoxyBlpIconProvider(
          rawPath: 'broken',
          iconDir: tempDir.path,
        );
        expect(await resolveViaStream(provider), isNull);
        final key = await provider.obtainKey(const ImageConfiguration());
        expect(
          PaintingBinding.instance.imageCache.statusForKey(key).untracked,
          isTrue,
        );
      },
    );

    test('The same key can load again when the missing file appears', () async {
      PaintingBinding.instance.imageCache.clear();
      // Resolve again after the file appears to verify that the failed load
      // was evicted and can be retried.
      final provider = FoxyBlpIconProvider(
        rawPath: 'late_icon',
        iconDir: tempDir.path,
      );
      expect(await resolveViaStream(provider), isNull);

      File(p.join(tempDir.path, 'late_icon.blp'))
          .writeAsBytesSync(File(fixtureBlp).readAsBytesSync());
      final info = await resolveViaStream(provider);
      expect(info, isNotNull);
      info!.dispose();
    });
  });
}

/// Loads through [ImageStream] and returns [ImageInfo] or null on failure.
Future<ImageInfo?> loadViaStream(FoxyBlpIconProvider provider) async {
  final key = await provider.obtainKey(const ImageConfiguration());
  final stream = ImageStream()
    ..setCompleter(provider.loadImage(key, _dummyDecode));
  return _listen(stream);
}

/// Resolves through [ImageProvider.resolve], returning [ImageInfo] or null.
Future<ImageInfo?> resolveViaStream(FoxyBlpIconProvider provider) async {
  final stream = provider.resolve(const ImageConfiguration());
  return _listen(stream);
}

/// FoxyBlpIconProvider decodes pixels directly without invoking this callback.
Future<ui.Codec> _dummyDecode(
  ui.ImmutableBuffer buffer, {
  ui.TargetImageSizeCallback? getTargetSize,
}) {
  throw StateError('decode callback should not be used by FoxyBlpIconProvider');
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
