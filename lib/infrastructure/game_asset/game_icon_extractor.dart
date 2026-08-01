import 'dart:io';

import 'package:path/path.dart' as p;

import 'game_icon_paths.dart';
import 'game_mpq_source.dart';

/// 单文件计数进度。
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

/// 提取结果。
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

/// 从魔兽客户端 locale MPQ 提取游戏图标到本地缓存目录。
///
/// 图标全部位于 `Data/<locale>/` 的 locale 包（`common.MPQ` 等大包中为 0），
/// 覆盖优先级链：`locale-<loc>` → `expansion-locale-<loc>` → `lichking-locale-<loc>`
/// → `patch-<loc>` → `patch-<loc>-2..9`（后打开者覆盖同名文件）。
/// 收录 `Interface\Icons\*` 与 `Interface\Spellbook\*`（glyph rune），
/// 以纯文件名扁平落盘，天然消化 `.tga` 残留路径与目录差异。
class GameIconExtractor {
  /// locale 偏好顺序（依次探测，取第一个含 locale MPQ 的）。
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

  /// 归档内图标目录前缀。
  static const _iconPrefixes = [r'interface\icons\', r'interface\spellbook\'];

  /// 单次提取的失败记录上限（防极端情况内存膨胀）。
  static const _maxRecordedErrors = 100;

  /// 归档打开工厂（测试注入内存假源）。
  final GameMpqSource Function(String archivePath) openSource;

  /// 魔兽客户端根目录（含 `Data/<locale>/`）。
  final String clientDir;

  /// 提取产物输出目录。
  final String outputDir;

  GameIconExtractor({
    required this.openSource,
    required this.clientDir,
    required this.outputDir,
  });

  /// 执行提取。
  ///
  /// [onProgress] 逐文件回调计数进度；[isCancelled] 每文件前检查，返回 true
  /// 时提前终止并标记结果 cancelled。已存在产物跳过。
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

    // 纯文件名 → (归档路径, 归档内路径)。后打开的归档覆盖同名条目。
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
          if (File(dest).existsSync()) {
            skipped++;
          } else {
            try {
              final bytes = source.extract(entry.value);
              if (bytes.isEmpty) {
                failed++;
                _recordError(errors, '${entry.value}: 提取结果为空');
              } else {
                File(dest).writeAsBytesSync(bytes);
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

  /// 归档收集（低 → 高优先级，后打开者覆盖同名文件）。
  ///
  /// 扫描 Data 根目录与选定 locale 目录下**全部** MPQ（自定义客户端可能
  /// 放任意命名的 patch 包覆盖或增加图标）。排序键 `(category, order)`：
  /// 0 官方大包（根目录 common*/expansion/lichking/alternate/patch*，按
  ///    AzerothCore 加载顺序，patch-N 高于 patch）
  /// 1 locale 基础包  2 locale 附加包  3 locale patch（`patch-<loc>-N` 高于 base）
  /// 4 自定义（其余全部，最后打开覆盖官方同名）。
  /// 组内其余按文件名排序保证确定性；不匹配 locale 名的 patch（如 patch-Z）
  /// 归入自定义 → 最后打开。
  static List<String> archiveChain(String dataRoot, String localeDataDir, String locale) {
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

  /// 定位 `Data/<locale>/` 目录：偏好顺序中第一个含 MPQ 归档的 locale；
  /// 无偏好命中时取第一个含 MPQ 的 locale 目录；均无则返回 null。
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

  /// 归档排序键（category 越大优先级越高；order 为类别内加载序号）。
  static (int, int) _archiveKey(String lowerName, String locale) {
    final localeLower = locale.toLowerCase();
    final base = lowerName.replaceAll('.mpq', '');

    final officialRoot = RegExp(
      r'^(common(-[0-9]+)?|expansion|lichking|alternate|patch(-[0-9]+)?)$',
    );
    if (officialRoot.hasMatch(base)) {
      // 与 AzerothCore CONF_mpq_list 加载顺序一致：patch-N 高于 patch。
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
    return (4, 0); // 自定义
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
        (entry) =>
            entry is File && entry.path.toLowerCase().endsWith('.mpq'),
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

/// 提取进度事件。
sealed class GameIconExtractProgress {
  const GameIconExtractProgress();
}

/// 阶段状态（扫描 / 准备）。
class GameIconExtractStatus extends GameIconExtractProgress {
  final String message;

  const GameIconExtractStatus(this.message);
}
