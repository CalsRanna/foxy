import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:foxy/infrastructure/game_asset/blp_decoder.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_paths.dart';
import 'package:path/path.dart' as p;

/// Logical identity of a game icon: the bare, normalized icon file name.
///
/// Used as the [ImageCache] key; equality is by name, so two providers
/// created from the same raw DBC path (e.g. on rebuild) share one cache
/// entry.
class BlpIconKey {
  /// Lowercase bare file name (directory and extension stripped).
  final String name;

  const BlpIconKey(this.name);

  @override
  bool operator ==(Object other) => other is BlpIconKey && other.name == name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => 'BlpIconKey($name)';
}

/// Loads a game icon (BLP) through the Flutter [ImageCache].
///
/// Input is the raw DBC icon path (e.g. `Interface\Icons\INV_Misc_Foo`);
/// the provider normalizes it to a bare file name, resolves the
/// `data/icon/<name>.blp` path, reads and decodes it, and yields a
/// one-frame image. File layout and decoding are encapsulated here — the
/// UI layer deals only with the logical icon path.
///
/// Missing or corrupt files surface as a stream error (rendered by the
/// caller's errorBuilder); the failed key is evicted from the [ImageCache]
/// so a later load (e.g. after the icon is extracted) is retried. Icons
/// are extracted by the user from the client MPQs on the settings page
/// (raw BLP format); the app ships no icons.
class BlpIconProvider extends ImageProvider<BlpIconKey> {
  /// Raw DBC icon path (backslashes, case-insensitive).
  final String rawPath;

  /// Icon directory override for tests; defaults to [GameIconPaths.iconDir].
  final String? iconDir;

  BlpIconProvider({
    required this.rawPath,
    this.iconDir,
  });

  String _pathFor(String name) => iconDir == null
      ? GameIconPaths.blpPath(name)
      : p.join(iconDir!, '$name.blp');

  @override
  Future<BlpIconKey> obtainKey(ImageConfiguration configuration) async =>
      BlpIconKey(GameIconPaths.normalizeIconName(rawPath));

  @override
  ImageStreamCompleter loadImage(BlpIconKey key, ImageDecoderCallback decode) =>
      OneFrameImageStreamCompleter(_load(key));

  Future<ImageInfo> _load(BlpIconKey key) async {
    final name = key.name;
    try {
      final file = File(_pathFor(name));
      if (!await file.exists()) {
        throw FileSystemException('icon file does not exist', file.path);
      }
      final bytes = await file.readAsBytes();
      final BlpImage decoded;
      try {
        decoded = BlpDecoder.decode(bytes);
      } on Object {
        // Corrupt/unsupported BLP: treat as missing.
        throw FileSystemException('failed to decode BLP', file.path);
      }
      final completer = Completer<ui.Image>();
      ui.decodeImageFromPixels(
        decoded.rgba,
        decoded.width,
        decoded.height,
        ui.PixelFormat.rgba8888,
        completer.complete,
      );
      return ImageInfo(image: await completer.future, scale: 1.0);
    } catch (_) {
      // A failed load otherwise stays in the ImageCache's pending map and
      // blocks any retry at the same key (e.g. after the icon is extracted).
      // Evict it, like the built-in providers, so the next resolve reads
      // from disk again. Safe to evict directly: _load always awaits file IO
      // before it can fail, so the cache has already tracked the key.
      PaintingBinding.instance.imageCache.evict(key);
      rethrow;
    }
  }

  @override
  bool operator ==(Object other) =>
      other is BlpIconProvider &&
      other.rawPath == rawPath &&
      other.iconDir == iconDir;

  @override
  int get hashCode => Object.hash(rawPath, iconDir);

  @override
  String toString() => 'BlpIconProvider($rawPath)';
}
