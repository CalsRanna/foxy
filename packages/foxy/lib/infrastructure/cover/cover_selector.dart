import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as p;

/// Discovers and picks the login-page cover image from the user-supplied
/// `data/cover/` directory (under the runtime working directory, next to
/// config.yaml).
///
/// Pure static functions with injectable randomness, so the picking logic
/// stays unit-testable without real images or a Flutter engine.
class CoverSelector {
  CoverSelector._();

  /// User cover images directory, same location as config.yaml.
  static String get defaultDirPath =>
      p.join(Directory.current.path, 'data', 'cover');

  /// Extensions accepted as cover images. Gif is intentionally excluded:
  /// animated images are not suitable as a static cover.
  static const supportedExtensions = {'.png', '.jpg', '.jpeg', '.webp'};

  /// Returns image files directly inside [dirPath] that pass both the
  /// extension whitelist and the magic-byte header check, sorted by path
  /// (stable input before shuffling). Non-recursive: subdirectories are
  /// ignored; a missing or unreadable directory yields an empty list.
  static List<File> listCandidates(String dirPath) {
    final dir = Directory(dirPath);
    if (!dir.existsSync()) return const [];
    try {
      final files = dir.listSync().whereType<File>().toList()
        ..sort((a, b) => a.path.compareTo(b.path));
      return files
          .where(
            (file) => supportedExtensions
                .contains(p.extension(file.path).toLowerCase()),
          )
          .where(_hasValidHeader)
          .toList();
    } on FileSystemException {
      // Unreadable directory: treat as empty instead of blocking the page.
      return const [];
    }
  }

  /// Picks one candidate at random (shuffle, then take the first), or null
  /// when the directory holds no supported image. Callers fall back to the
  /// built-in asset when null.
  static File? pick(String dirPath, {Random? random}) {
    final candidates = listCandidates(dirPath);
    if (candidates.isEmpty) return null;
    final shuffled = [...candidates]..shuffle(random ?? Random());
    return shuffled.first;
  }

  /// Magic-byte validation (first 12 bytes of the header), so a file whose
  /// extension lies — e.g. a .txt renamed to .png — never reaches the
  /// decoder. Public so tests can feed synthetic headers without touching
  /// the file system.
  static bool isSupportedImageHeader(List<int> header) {
    if (_startsWith(header, _pngMagic)) return true;
    if (_startsWith(header, _jpegMagic)) return true;
    // WebP: 'RIFF' container with a 'WEBP' chunk type at offset 8.
    return header.length >= 12 &&
        _startsWith(header, _riffMagic) &&
        _startsWith(header.sublist(8), _webpMagic);
  }

  static const _pngMagic = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A];
  static const _jpegMagic = [0xFF, 0xD8];
  static const _riffMagic = [0x52, 0x49, 0x46, 0x46]; // 'RIFF'
  static const _webpMagic = [0x57, 0x45, 0x42, 0x50]; // 'WEBP'

  static bool _hasValidHeader(File file) {
    try {
      final handle = file.openSync();
      try {
        return isSupportedImageHeader(handle.readSync(12));
      } finally {
        handle.closeSync();
      }
    } on FileSystemException {
      return false;
    }
  }

  static bool _startsWith(List<int> bytes, List<int> magic) {
    if (bytes.length < magic.length) return false;
    for (var i = 0; i < magic.length; i++) {
      if (bytes[i] != magic[i]) return false;
    }
    return true;
  }
}
