import 'dart:io';

import 'package:path/path.dart' as p;

/// Locates the DBC file directory inside a server root directory.
///
/// Server layouts are not fixed (AzerothCore / TrinityCore / custom
/// builds), so resolution cannot rely on a single known path: common
/// locations are probed first, then the whole root is searched recursively
/// for a directory that directly contains `.dbc` files, skipping obvious
/// source/build/VCS trees.
class ServerDirResolver {
  /// Maximum recursion depth of the fallback search.
  static const maxDepth = 6;

  /// Directories never worth descending into: source trees, dependencies,
  /// build artifacts, VCS metadata.
  static const _skipNames = {
    '.git',
    '.svn',
    '.hg',
    'deps',
    'src',
    'build',
    'node_modules',
    'env',
    'venv',
    'cmake-build-debug',
    'cmake-build-release',
  };

  /// Returns the first directory directly containing `.dbc` files, or null
  /// when none is found. Returned paths are normalized to the platform
  /// separator (Windows `Directory.path` can otherwise mix `\` and `/`).
  static Future<String?> findDbcDir(String serverRoot) async {
    // Common locations first: shallow, fast to check.
    for (final relative in const ['data/dbc', 'dbc']) {
      final candidate = Directory(p.join(serverRoot, relative));
      if (await _containsDbc(candidate)) return p.normalize(candidate.path);
    }
    return _search(serverRoot, 0);
  }

  static Future<String?> _search(String root, int depth) async {
    if (depth > maxDepth) return null;
    final directory = Directory(root);
    try {
      await for (final entity in directory.list(followLinks: false)) {
        if (entity is! Directory) continue;
        final name = p.basename(entity.path).toLowerCase();
        if (_skipNames.contains(name)) continue;
        if (await _containsDbc(entity)) return p.normalize(entity.path);
        final found = await _search(entity.path, depth + 1);
        if (found != null) return found;
      }
    } on FileSystemException {
      // Unreadable/raced directories do not block the search.
    }
    return null;
  }

  /// Whether [directory] directly contains at least one `.dbc` file (no
  /// recursion into subdirectories).
  static Future<bool> _containsDbc(Directory directory) async {
    try {
      await for (final entity in directory.list(followLinks: false)) {
        if (entity is File && entity.path.toLowerCase().endsWith('.dbc')) {
          return true;
        }
      }
    } on FileSystemException {
      return false;
    }
    return false;
  }
}
