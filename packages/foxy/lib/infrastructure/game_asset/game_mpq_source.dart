import 'dart:typed_data';

import 'package:warcrafty/warcrafty.dart';

/// Read-only abstraction over an MPQ archive, injected into the icon
/// extractor (tests substitute an in-memory fake).
abstract interface class GameMpqSource {

  /// All file paths inside the archive (`\`-separated).
  List<String> get files;

  void close();

  /// Extracts an in-archive file as in-memory bytes.
  Uint8List extract(String name);
}

/// Hard cap on a single extracted in-archive file. warcrafty's sector reader
/// allocates `block.fileSize` (a hostile uint32, up to 4 GiB) before
/// checking the real data; this wrapper rejects the result once it exceeds
/// the cap. It cannot prevent the allocation *during* [MpqArchive.extract]
/// — that needs a warcrafty-side fix (tracked upstream) — but it stops
/// oversized payloads from flowing into the rest of the pipeline. Icons are
/// BLP files of a few hundred KB at most, so the cap is far above any
/// legitimate file.


/// Implementation based on warcrafty (pure-Dart MPQ).
final class WarcraftyMpqSource implements GameMpqSource {
  static const _maxExtractedBytes = 64 << 20; // 64 MiB

  final MpqArchive _archive;

  WarcraftyMpqSource(String archivePath)
    : _archive = MpqArchive.open(archivePath);

  @override
  List<String> get files => _archive.files;

  @override
  void close() => _archive.close();

  @override
  Uint8List extract(String name) {
    final bytes = _archive.extract(name);
    if (bytes.length > _maxExtractedBytes) {
      throw MpqCorruptException(
        'extracted file $name exceeds the $_maxExtractedBytes byte cap',
      );
    }
    return bytes;
  }
}
