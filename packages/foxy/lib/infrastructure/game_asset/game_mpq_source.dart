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

/// Implementation based on warcrafty (pure-Dart MPQ).
final class WarcraftyMpqSource implements GameMpqSource {
  final MpqArchive _archive;

  WarcraftyMpqSource(String archivePath)
    : _archive = MpqArchive.open(archivePath);

  @override
  List<String> get files => _archive.files;

  @override
  void close() => _archive.close();

  @override
  Uint8List extract(String name) => _archive.extract(name);
}
