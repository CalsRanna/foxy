import 'dart:io';

import 'package:path/path.dart' as p;

/// Central definitions for the game-icon cache directory and name
/// normalization.
class GameIconPaths {
  /// Icon cache directory (`data/icon/` under the runtime working
  /// directory, same location as config.yaml).
  static String get iconDir => p.join(Directory.current.path, 'data', 'icon');

  GameIconPaths._();

  /// Bare file name → extracted-file path.
  static String blpPath(String name) => p.join(iconDir, '$name.blp');

  /// Normalizes a raw DBC icon path to a lowercase bare file name
  /// (directory and extension stripped).
  ///
  /// E.g. both `Interface\Icons\INV_Misc_Foo` and `inv_shoulder_94.tga`
  /// normalize to bare names (`inv_misc_foo` / `inv_shoulder_94`),
  /// matching the flat layout of extracted files.
  static String normalizeIconName(String rawPath) {
    var name = rawPath.toLowerCase().replaceAll('\\', '/');
    final slash = name.lastIndexOf('/');
    if (slash >= 0) name = name.substring(slash + 1);
    final dot = name.lastIndexOf('.');
    if (dot > 0) name = name.substring(0, dot);
    return name;
  }
}
