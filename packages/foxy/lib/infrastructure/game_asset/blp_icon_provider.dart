import 'dart:async';
import 'dart:collection';
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

/// Bounded negative cache for icon load failures (file missing or BLP
/// corrupt/unsupported).
///
/// The [ImageCache] does not cache failed loads, so without this a newly
/// visible row for a non-extracted icon would re-run `File.exists()` every
/// time it scrolls back into view. Records are LRU-bounded (most icons are
/// not extracted, but the total icon set is ~6300); [clear] is called after
/// a successful extraction so newly written files are picked up.
///
/// Misses and decode failures share one cache: both render the same
/// placeholder, and both are invalidated by extraction.
class BlpIconCache {
  static final BlpIconCache instance = BlpIconCache();

  final int _maxEntries;

  /// Insertion-ordered set; hits re-insert to promote to the back, and
  /// overflow drops the front (least recently used).
  final LinkedHashSet<String> _misses = LinkedHashSet();

  BlpIconCache({int maxEntries = 2048}) : _maxEntries = maxEntries;

  /// Records a failed load, evicting the least-recently-used entry when
  /// over the bound.
  void add(String name) {
    _misses.remove(name);
    _misses.add(name);
    while (_misses.length > _maxEntries) {
      _misses.remove(_misses.first);
    }
  }

  bool contains(String name) {
    if (!_misses.contains(name)) return false;
    // Promote on hit so frequently scrolled icons stay cached longest.
    _misses.remove(name);
    _misses.add(name);
    return true;
  }

  /// Empties the cache (called after icon extraction, so pre-extraction
  /// misses are forgotten).
  void clear() => _misses.clear();
}

/// Loads a game icon (BLP) through the Flutter [ImageCache].
///
/// Input is the raw DBC icon path (e.g. `Interface\Icons\INV_Misc_Foo`);
/// the provider normalizes it to a bare file name, resolves the
/// `data/icon/<name>.blp` path, reads and decodes it, and yields a
/// one-frame image. File layout and decoding are encapsulated here — the
/// UI layer deals only with the logical icon path.
///
/// Missing or corrupt files are recorded in the [BlpIconCache] negative
/// cache and surface as a stream error (rendered by the caller's
/// errorBuilder). Icons are extracted by the user from the client MPQs on
/// the settings page (raw BLP format); the app ships no icons.
class BlpIconProvider extends ImageProvider<BlpIconKey> {
  /// Raw DBC icon path (backslashes, case-insensitive).
  final String rawPath;

  /// Negative cache; injectable for tests, defaults to the app-wide one.
  final BlpIconCache negativeCache;

  /// Icon directory override for tests; defaults to [GameIconPaths.iconDir].
  final String? iconDir;

  BlpIconProvider({
    required this.rawPath,
    BlpIconCache? negativeCache,
    this.iconDir,
  }) : negativeCache = negativeCache ?? BlpIconCache.instance;

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
    if (negativeCache.contains(name)) {
      throw FileSystemException('icon previously failed to load', name);
    }
    final file = File(_pathFor(name));
    if (!await file.exists()) {
      negativeCache.add(name);
      throw FileSystemException('icon file does not exist', file.path);
    }
    final bytes = await file.readAsBytes();
    final BlpImage decoded;
    try {
      decoded = BlpDecoder.decode(bytes);
    } on Object {
      // Corrupt/unsupported BLP: record and treat as missing.
      negativeCache.add(name);
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
