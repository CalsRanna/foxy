import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:foxy/infrastructure/game_asset/blp_decoder.dart';

/// In-memory cache for BLP game icons: file → decode → `ui.Image` reuse.
///
/// Icons are 64×64 and decode in under a millisecond; the cache avoids
/// re-decoding the same icon during list scrolls. Uses LRU (access
/// promotes to front); over-limit entries evict the least-recently-used
/// one.
class GameIconCache {
  static final GameIconCache instance = GameIconCache();

  final int _maxEntries;

  final LinkedHashMap<String, ui.Image> _images = LinkedHashMap();

  /// Negative cache for definite misses (file absent): by default most
  /// icons are not extracted, and a File.exists() per newly visible row is
  /// pure wasted IO round-trips.
  final Set<String> _missing = {};

  /// Clear/version coordination: after clear(), all in-flight decode
  /// results are discarded, so disposed old textures are never written
  /// back into the cache or drawn again.
  int _generation = 0;

  final Map<String, Future<ui.Image?>> _pending = {};
  GameIconCache({int maxEntries = 256}) : _maxEntries = maxEntries;

  /// Empties the cache (called after extraction, so deleted old icons are
  /// never referenced).
  void clear() {
    _generation++;
    for (final image in _images.values) {
      image.dispose();
    }
    _images.clear();
    _missing.clear();
  }

  /// Whether the path is cached (for tests and diagnostics).
  bool contains(String path) => _images.containsKey(path);

  /// Loads and decodes a BLP file; returns null if the file is missing or
  /// decoding fails.
  Future<ui.Image?> load(String path) async {
    if (_missing.contains(path)) return null;
    final cached = _images.remove(path);
    if (cached != null) {
      _images[path] = cached; // promote to front
      return cached;
    }
    final inFlight = _pending[path];
    if (inFlight != null) return inFlight;

    final generation = _generation;
    final future = _decode(path).then(
      (image) {
        if (image != null && generation == _generation) {
          _images.remove(path);
          _images[path] = image;
          while (_images.length > _maxEntries) {
            // Evict the least-recently-used entry and explicitly release
            // its GPU texture.
            final evicted = _images.remove(_images.keys.first);
            evicted?.dispose();
          }
        } else if (image != null) {
          // Decodes completing during clear(): the cache is empty, so drop
          // and release the texture.
          image.dispose();
          return null;
        }
        _pending.remove(path);
        return image;
      },
      onError: (Object _) {
        // Decode/IO failures must not leave a failed in-flight future:
        // later load() calls should retry instead of always getting the
        // same failure.
        _pending.remove(path);
        return null;
      },
    );
    _pending[path] = future;
    return future;
  }

  Future<ui.Image?> _decode(String path) async {
    final file = File(path);
    try {
      if (!await file.exists()) {
        _missing.add(path);
        return null;
      }
      final bytes = await file.readAsBytes();
      final BlpImage decoded;
      try {
        decoded = decodeBlp(bytes);
      } on Object {
        return null; // treat corrupt/unsupported BLP as missing, show placeholder
      }
      final completer = Completer<ui.Image>();
      ui.decodeImageFromPixels(
        decoded.rgba,
        decoded.width,
        decoded.height,
        ui.PixelFormat.rgba8888,
        completer.complete,
      );
      return completer.future;
    } on Object {
      // File-read IO errors (e.g. the file is deleted between exists and
      // readAsBytes) are treated as missing.
      return null;
    }
  }
}
