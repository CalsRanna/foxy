import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:ui' as ui;

import 'blp_decoder.dart';

/// BLP 游戏图标的内存缓存：文件 → 解码 → `ui.Image` 复用。
///
/// 图标为 64×64，解码亚毫秒级；缓存避免列表滚动时同一图标反复解码。
/// 采用 LRU（访问即置顶），超限时淘汰最久未用条目。
class GameIconCache {
  static final GameIconCache instance = GameIconCache();

  final int _maxEntries;

  final LinkedHashMap<String, ui.Image> _images = LinkedHashMap();

  /// 确定性缺失（文件不存在）的负缓存：默认状态下大量图标未提取，
  /// 每个新可见行都重新 File.exists() 是纯浪费的 IO 往返。
  final Set<String> _missing = {};

  /// 清空/版本协调：clear() 后 in-flight 解码结果一律丢弃，
  /// 避免已 dispose 的旧纹理被重新写回缓存或继续绘制。
  int _generation = 0;

  final Map<String, Future<ui.Image?>> _pending = {};
  GameIconCache({int maxEntries = 256}) : _maxEntries = maxEntries;

  /// 清空缓存（提取完成后调用，避免引用已删除的旧图标）。
  void clear() {
    _generation++;
    for (final image in _images.values) {
      image.dispose();
    }
    _images.clear();
    _missing.clear();
  }

  /// 是否已缓存（供测试与诊断）。
  bool contains(String path) => _images.containsKey(path);

  /// 加载并解码 BLP 文件；文件缺失或解码失败返回 null。
  Future<ui.Image?> load(String path) async {
    if (_missing.contains(path)) return null;
    final cached = _images.remove(path);
    if (cached != null) {
      _images[path] = cached; // 置顶
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
            // 淘汰最久未用条目并显式释放其 GPU 纹理。
            final evicted = _images.remove(_images.keys.first);
            evicted?.dispose();
          }
        } else if (image != null) {
          // clear() 期间完成的解码:缓存已清空,丢弃并释放纹理。
          image.dispose();
          return null;
        }
        _pending.remove(path);
        return image;
      },
      onError: (Object _) {
        // 解码/IO 失败不残留失败的 in-flight future:
        // 后续 load() 应重新尝试而不是永远拿到同一个失败。
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
        return null; // 损坏/不支持的 BLP 按缺失处理，显示占位。
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
      // 读文件 IO 异常(文件在 exists 与 readAsBytes 之间被删等)按缺失处理。
      return null;
    }
  }
}
