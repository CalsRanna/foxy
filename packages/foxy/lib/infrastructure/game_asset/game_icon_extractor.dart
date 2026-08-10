import 'dart:io';

import 'package:path/path.dart' as p;

import 'package:foxy/infrastructure/game_asset/game_icon_paths.dart';
import 'package:foxy/infrastructure/game_asset/game_mpq_source.dart';

/// Per-file count progress.
class GameIconExtractCount extends GameIconExtractProgress {
  final String fileName;
  final int completed;
  final int total;

  const GameIconExtractCount({
    required this.fileName,
    required this.completed,
    required this.total,
  });
}

/// Extraction result.
class GameIconExtractionResult extends GameIconExtractProgress {
  final int extracted;
  final int skipped;
  final int failed;
  final List<String> errors;
  final bool cancelled;

  const GameIconExtractionResult({
    required this.extracted,
    required this.skipped,
    required this.failed,
    required this.errors,
    required this.cancelled,
  });

  bool get success => !cancelled && failed == 0;
}

/// Extracts game icons from the WoW client's locale MPQs into a local
/// cache directory.
///
/// Icons live only in the locale packs under `Data/<locale>/` (0 in big
/// packs like `common.MPQ`), with an override-priority chain:
/// `locale-<loc>` → `expansion-locale-<loc>` → `lichking-locale-<loc>` →
/// `patch-<loc>` → `patch-<loc>-2..9` (later-opened archives override
/// same-named files). Collects `Interface\Icons\*` and
/// `Interface\Spellbook\*` (glyph runes), flattened to bare file names on
/// disk, which naturally absorbs `.tga` leftovers and directory
/// differences.
class GameIconExtractor {
  /// Locale preference order (probed in sequence; the first one with a
  /// locale MPQ wins).
  static const localePreference = [
    'zhCN',
    'zhTW',
    'enCN',
    'enUS',
    'enGB',
    'koKR',
    'ruRU',
    'deDE',
    'esES',
    'esMX',
    'frFR',
  ];

  /// Icon directory prefixes inside archives.
  static const _iconPrefixes = [r'interface\icons\', r'interface\spellbook\'];

  /// Cap on recorded failures per extraction run (guards against memory
  /// growth in extreme cases).
  static const _maxRecordedErrors = 100;

  /// Archive-opening factory (tests inject an in-memory fake source).
  final GameMpqSource Function(String archivePath) openSource;

  /// WoW client root directory (contains `Data/<locale>/`).
  final String clientDir;

  /// Output directory for extracted files.
  final String outputDir;

  GameIconExtractor({
    required this.openSource,
    required this.clientDir,
    required this.outputDir,
  });

  /// Runs the extraction.
  ///
  /// [onProgress] receives per-file count progress; [isCancelled] is
  /// checked before each file — when it returns true, extraction stops
  /// early and the result is marked cancelled. Already-extracted files are
  /// skipped.
  GameIconExtractionResult extract({
    void Function(GameIconExtractProgress progress)? onProgress,
    bool Function()? isCancelled,
  }) {
    final localeDataDir = findLocaleDataDir(clientDir);
    if (localeDataDir == null) {
      return GameIconExtractionResult(
        extracted: 0,
        skipped: 0,
        failed: 1,
        errors: ['未在客户端目录中找到 Data/<locale> 归档目录：$clientDir'],
        cancelled: false,
      );
    }
    final locale = p.basename(localeDataDir);
    final chain = archiveChain(
      p.join(clientDir, 'Data'),
      localeDataDir,
      locale,
    );
    if (chain.isEmpty) {
      return GameIconExtractionResult(
        extracted: 0,
        skipped: 0,
        failed: 1,
        errors: ['$localeDataDir 中没有找到 MPQ 归档'],
        cancelled: false,
      );
    }

    onProgress?.call(GameIconExtractStatus('正在扫描 $locale 客户端归档...'));
    final errors = <String>[];
    var failed = 0;

    // Bare file name → (archive path, in-archive path). Later-opened
    // archives override same-named entries.
    final index = <String, ({String archivePath, String innerPath})>{};
    for (final archivePath in chain) {
      if (_isCancelled(isCancelled)) {
        return _cancelled(0, 0, failed, errors);
      }
      GameMpqSource? source;
      try {
        source = openSource(archivePath);
        for (final file in source.files) {
          final lower = file.toLowerCase();
          if (!_isIconPath(lower)) continue;
          final plain = GameIconPaths.normalizeIconName(file);
          if (plain.isEmpty) continue;
          index[plain] = (archivePath: archivePath, innerPath: file);
        }
      } catch (error) {
        failed++;
        _recordError(errors, '${p.basename(archivePath)}: $error');
      } finally {
        source?.close();
      }
    }

    onProgress?.call(GameIconExtractStatus('正在提取图标...'));
    Directory(outputDir).createSync(recursive: true);
    final byArchive = <String, List<MapEntry<String, String>>>{};
    for (final entry in index.entries) {
      byArchive
          .putIfAbsent(entry.value.archivePath, () => [])
          .add(MapEntry(entry.key, entry.value.innerPath));
    }

    final total = index.length;
    var done = 0;
    var extracted = 0;
    var skipped = 0;
    for (final archivePath in chain) {
      final entries = byArchive[archivePath];
      if (entries == null) continue;
      GameMpqSource? source;
      try {
        source = openSource(archivePath);
        for (final entry in entries) {
          if (_isCancelled(isCancelled)) {
            return _cancelled(extracted, skipped, failed, errors);
          }
          done++;
          final dest = p.join(outputDir, '${entry.key}.blp');
          // A previous interrupted run (force-kill mid-write) may leave a
          // truncated file; only treat a non-empty destination as done.
          if (File(dest).existsSync() && File(dest).lengthSync() > 0) {
            skipped++;
          } else {
            try {
              final bytes = source.extract(entry.value);
              if (bytes.isEmpty) {
                failed++;
                _recordError(errors, '${entry.value}: 提取结果为空');
              } else {
                // Atomic-ish write: write to a `.part` file first, then
                // rename into place, so an interruption never leaves a
                // truncated `.blp` that would be permanently skipped.
                final part = File('$dest.part');
                part.writeAsBytesSync(bytes);
                part.renameSync(dest);
                extracted++;
              }
            } catch (error) {
              failed++;
              _recordError(errors, '${entry.value}: $error');
            }
          }
          onProgress?.call(
            GameIconExtractCount(
              fileName: entry.key,
              completed: done,
              total: total,
            ),
          );
        }
      } catch (error) {
        failed += entries.length;
        _recordError(errors, '${p.basename(archivePath)}: $error');
      } finally {
        source?.close();
      }
    }

    return GameIconExtractionResult(
      extracted: extracted,
      skipped: skipped,
      failed: failed,
      errors: errors,
      cancelled: false,
    );
  }

  /// Archive collection (low → high priority; later-opened archives
  /// override same-named files).
  ///
  /// Scans **all** MPQs under the Data root and the chosen locale directory
  /// (custom clients may ship arbitrarily named patch packs that override
  /// or add icons). Sort key `(category, order)`:
  /// 0 official big packs (root common*/expansion/lichking/alternate/patch*,
  ///    in AzerothCore load order; patch-N ranks above patch)
  /// 1 locale base pack  2 locale extra packs  3 locale patch
  ///    (`patch-<loc>-N` above base)
  /// 4 custom (everything else, opened last to override official
  ///    same-named files).
  /// Within a group, remaining files sort by name for determinism; patches
  /// not matching the locale name (e.g. patch-Z) fall into custom →
  /// opened last.
  static List<String> archiveChain(
    String dataRoot,
    String localeDataDir,
    String locale,
  ) {
    final archives = <({String path, int category, int order})>[];
    void collect(String dir) {
      final Directory directory;
      try {
        directory = Directory(dir);
        if (!directory.existsSync()) return;
      } on FileSystemException {
        return;
      }
      for (final entry in directory.listSync()) {
        if (entry is! File || !entry.path.toLowerCase().endsWith('.mpq')) {
          continue;
        }
        final name = p.basename(entry.path).toLowerCase();
        final (category, order) = _archiveKey(name, locale);
        archives.add((path: entry.path, category: category, order: order));
      }
    }

    collect(dataRoot);
    collect(localeDataDir);

    archives.sort((a, b) {
      if (a.category != b.category) return a.category - b.category;
      if (a.order != b.order) return a.order - b.order;
      return a.path.toLowerCase().compareTo(b.path.toLowerCase());
    });
    return [for (final archive in archives) archive.path];
  }

  /// Locates the `Data/<locale>/` directory: the first locale in
  /// preference order containing an MPQ archive; if no preference hits,
  /// the first locale directory with an MPQ; null if none exist.
  static String? findLocaleDataDir(String clientDir) {
    final dataDir = p.join(clientDir, 'Data');
    final Directory directory;
    try {
      directory = Directory(dataDir);
      if (!directory.existsSync()) return null;
    } on FileSystemException {
      return null;
    }
    final entries = directory.listSync().whereType<Directory>().toList();
    if (entries.isEmpty) return null;

    final byName = <String, Directory>{
      for (final entry in entries) p.basename(entry.path).toLowerCase(): entry,
    };
    for (final locale in localePreference) {
      final dir = byName[locale.toLowerCase()];
      if (dir != null && _hasMpq(dir.path)) return dir.path;
    }
    for (final entry in entries) {
      if (_hasMpq(entry.path)) return entry.path;
    }
    return null;
  }

  /// Archive sort key (higher category = higher priority; order is the
  /// load sequence within a category).
  static (int, int) _archiveKey(String lowerName, String locale) {
    final localeLower = locale.toLowerCase();
    final base = lowerName.replaceAll('.mpq', '');

    final officialRoot = RegExp(
      r'^(common(-[0-9]+)?|expansion|lichking|alternate|patch(-[0-9]+)?)$',
    );
    if (officialRoot.hasMatch(base)) {
      // Matches AzerothCore's CONF_mpq_list load order: patch-N above
      // patch.
      final order = switch (base) {
        'common' => 0,
        'common-2' => 1,
        'expansion' => 2,
        'lichking' => 3,
        'alternate' => 4,
        'patch' => 5,
        _ when base.startsWith('patch-') =>
          5 + (int.tryParse(base.substring('patch-'.length)) ?? 1),
        _ => 6,
      };
      return (0, order);
    }
    if (base == 'locale-$localeLower') return (1, 0);
    if (base == 'expansion-locale-$localeLower' ||
        base == 'lichking-locale-$localeLower') {
      return (2, 0);
    }
    if (base == 'patch-$localeLower') return (3, 0);
    final localePatchN = RegExp(r'^patch-' + localeLower + r'-([0-9]+)$');
    final match = localePatchN.firstMatch(base);
    if (match != null) {
      return (3, int.tryParse(match.group(1)!) ?? 1);
    }
    return (4, 0); // custom
  }

  static GameIconExtractionResult _cancelled(
    int extracted,
    int skipped,
    int failed,
    List<String> errors,
  ) {
    return GameIconExtractionResult(
      extracted: extracted,
      skipped: skipped,
      failed: failed,
      errors: errors,
      cancelled: true,
    );
  }

  static bool _hasMpq(String dirPath) {
    try {
      return Directory(dirPath).listSync().any(
        (entry) => entry is File && entry.path.toLowerCase().endsWith('.mpq'),
      );
    } on FileSystemException {
      return false;
    }
  }

  static bool _isCancelled(bool Function()? isCancelled) =>
      isCancelled?.call() ?? false;

  static bool _isIconPath(String lower) =>
      _iconPrefixes.any(lower.startsWith) && lower.endsWith('.blp');

  static void _recordError(List<String> errors, String message) {
    if (errors.length < _maxRecordedErrors) {
      errors.add(message);
    } else if (errors.length == _maxRecordedErrors) {
      errors.add('...其余错误已省略');
    }
  }
}

/// Extraction progress event.
sealed class GameIconExtractProgress {
  const GameIconExtractProgress();
}

/// Phase status (scanning / preparing).
class GameIconExtractStatus extends GameIconExtractProgress {
  final String message;

  const GameIconExtractStatus(this.message);
}
