/// Generates the update manifest `latest.yaml` and the GitHub Release
/// notes `release_notes.md`.
///
/// Invoked by the release pipeline (`.github/workflows/release.yml`) after
/// the zip is built:
///
/// ```bash
/// dart run tool/release/make_update_manifest.dart \
///   --zip foxy-1.1.0.zip --tag v1.1.0 \
///   --out latest.yaml --notes-out release_notes.md \
///   [--existing latest.yaml]
/// ```
///
/// Data sources:
/// - version: `pubspec.yaml`'s `version` field (must match the `--tag`
///   major version);
/// - notes: the `## <tag>` section of `CHANGELOG.md` (prerelease tags fall
///   back to the major-version section);
/// - checksum: the zip file's SHA-256 and byte size.
///
/// Manifest structure (YAML; the releases array keeps the most recent
/// versions, newest first):
///
/// ```yaml
/// schemaVersion: 1
/// appId: com.calsranna.foxy
/// releases:
///   - version: "1.1.0"
///     buildNumber: "630"
///     isPrerelease: false
///     zipUrl: https://github.com/CalsRanna/foxy/releases/download/v1.1.0/foxy-1.1.0.zip
///     sizeBytes: 23760804
///     sha256: abc...
///     notes: |-
///       update notes
///     releasedAt: 2026-08-02T...
/// ```
///
/// When `--existing` passes the previous manifest, entries are merged to
/// keep the most recent [keepReleases] (old entries with the same
/// version+buildNumber are replaced); without it, or on parse failure,
/// only the current entry is written. Structure aligned with the app-side
/// `UpdateManifestInfo.fromMap`
/// (`lib/infrastructure/update/update_service.dart`)。
library;

import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:yaml/yaml.dart';

abstract final class MakeUpdateManifest {
  static const _repo = 'CalsRanna/foxy';
  static const _appId = 'com.calsranna.foxy';

  /// Cap on the number of release entries kept in the manifest.
  static const keepReleases = 3;

  static Future<void> run(List<String> args) async {
    final options = _parseArgs(args);
    final zipPath = options['--zip'];
    final tag = options['--tag'];
    final outPath = options['--out'];
    final notesOutPath = options['--notes-out'];
    final existingPath = options['--existing'];
    if (zipPath == null || tag == null || outPath == null) {
      stderr.writeln(
        '用法: dart run tool/release/make_update_manifest.dart '
        '--zip <zip> --tag <vX.Y.Z> --out <latest.yaml> '
        '[--notes-out <notes.md>] [--existing <latest.yaml>]',
      );
      exit(2);
    }

    // 1. Version: pubspec and tag major versions must match (single source
    //    of truth). The tag may carry a prerelease suffix (e.g.
    //    v1.1.0-beta); the suffix never enters pubspec and only marks test
    //    releases: the app side skips prerelease updates on that basis (see
    //    `UpdateManifestInfo.isPrerelease`)。
    final version = _readPubspecVersion();
    final mainTag = _stripPrereleaseSuffix(tag);
    if (!mainTag.startsWith('v') || mainTag.substring(1) != version) {
      stderr.writeln('tag($tag) 主版本与 pubspec 版本($version)不一致,拒绝生成');
      exit(1);
    }
    final isPrerelease = mainTag != tag;
    final buildNumber = _readPubspecBuildNumber();

    // 2. Notes: the `## <tag>` section of CHANGELOG.md (prerelease falls
    //    back to the major-version section).
    final notes = _readChangelogSection(tag);

    // 3. zip checksum.
    final zipFile = File(zipPath);
    if (!await zipFile.exists()) {
      stderr.writeln('zip 不存在: $zipPath');
      exit(1);
    }
    final sha256Hex = (await sha256.bind(zipFile.openRead()).first).bytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
    final sizeBytes = await zipFile.length();

    // 4. Merge historical releases (replace same version+buildNumber, keep
    //    the most recent N).
    final current = <String, Object?>{
      'version': version,
      'buildNumber': buildNumber,
      'isPrerelease': isPrerelease,
      'zipUrl':
          'https://github.com/$_repo/releases/download/$tag/foxy-$version.zip',
      'sizeBytes': sizeBytes,
      'sha256': sha256Hex,
      'notes': notes,
      'releasedAt': DateTime.now().toUtc().toIso8601String(),
    };
    final releases = <Map<String, Object?>>[current];
    if (existingPath != null && File(existingPath).existsSync()) {
      final existing = _readExistingReleases(existingPath, version, buildNumber);
      releases.addAll(existing);
    }
    final kept = releases.take(keepReleases).toList();

    // 5. Write latest.yaml.
    await File(outPath).writeAsString(_dumpYaml(kept));

    // 6. Write the GitHub Release notes (optional).
    if (notesOutPath != null) {
      await File(notesOutPath).writeAsString('## Foxy $version\n\n$notes');
    }

    stdout.writeln('latest.yaml 已生成: version=$version build=$buildNumber '
        'isPrerelease=$isPrerelease releases=${kept.length} '
        'size=$sizeBytes sha256=${sha256Hex.substring(0, 12)}…');
  }

  /// Reads the existing manifest's releases, dropping entries matching the
  /// current (version, buildNumber).
  ///
  /// On parse failure (corrupt/mismatched file) returns an empty list —
  /// better a manifest with only the current entry than an interrupted
  /// release.
  static List<Map<String, Object?>> _readExistingReleases(
    String existingPath,
    String version,
    String buildNumber,
  ) {
    try {
      final decoded = loadYaml(File(existingPath).readAsStringSync());
      if (decoded is! Map) return const [];
      final releases = decoded['releases'];
      if (releases is! List) return const [];
      final result = <Map<String, Object?>>[];
      for (final item in releases) {
        if (item is! Map) continue;
        if (item['version'] == version && item['buildNumber'] == buildNumber) {
          continue; // re-releasing the same version: replace the old entry
        }
        result.add(_stringifyKeys(item));
      }
      return result;
    } catch (error) {
      stderr.writeln('解析现有清单失败,仅保留当前条目: $error');
      return const [];
    }
  }

  /// Normalizes YamlMap keys to String (loadYaml may return dynamic keys).
  static Map<String, Object?> _stringifyKeys(Map item) {
    return {
      for (final entry in item.entries)
        if (entry.key is String) entry.key: entry.value,
    };
  }

  /// Outputs the YAML manifest (structure in the file-header comment).
  static String _dumpYaml(List<Map<String, Object?>> releases) {
    final buffer = StringBuffer();
    buffer.writeln('# Foxy 更新清单(CI 自动生成,请勿手改)');
    buffer.writeln('schemaVersion: 1');
    buffer.writeln('appId: $_appId');
    buffer.writeln('releases:');
    for (final release in releases) {
      buffer.writeln('  - version: "${release['version']}"');
      buffer.writeln('    buildNumber: "${release['buildNumber']}"');
      buffer.writeln('    isPrerelease: ${release['isPrerelease']}');
      buffer.writeln('    zipUrl: ${release['zipUrl']}');
      buffer.writeln('    sizeBytes: ${release['sizeBytes']}');
      buffer.writeln('    sha256: ${release['sha256']}');
      // Block scalar `|-`: multi-line notes, trailing newline stripped,
      // content indented 6 spaces.
      buffer.writeln('    notes: |-');
      for (final line in (release['notes'] as String).split('\n')) {
        buffer.writeln('      $line');
      }
      buffer.writeln('    releasedAt: ${release['releasedAt']}');
    }
    return buffer.toString();
  }

  /// Strips the tag's prerelease suffix: `v1.1.0-beta` → `v1.1.0`.
  ///
  /// A prerelease suffix is `-` followed by alphanumerics/dots/hyphens
  /// (e.g. `-beta`, `-rc.1`). Tags without a suffix are returned as-is.
  static String _stripPrereleaseSuffix(String tag) {
    final dash = tag.indexOf('-');
    if (dash < 0) return tag;
    final suffix = tag.substring(dash + 1);
    if (suffix.isEmpty || !RegExp(r'^[A-Za-z0-9.\-]+$').hasMatch(suffix)) {
      return tag;
    }
    return tag.substring(0, dash);
  }

  static String _readPubspecVersion() {
    final pubspec = _loadPubspec();
    final version = pubspec['version'];
    if (version is! String) {
      stderr.writeln('pubspec.yaml 缺少 version 字段');
      exit(1);
    }
    final plus = version.indexOf('+');
    return plus < 0 ? version : version.substring(0, plus);
  }

  static String _readPubspecBuildNumber() {
    final pubspec = _loadPubspec();
    final version = pubspec['version'];
    if (version is! String) {
      stderr.writeln('pubspec.yaml 缺少 version 字段');
      exit(1);
    }
    final plus = version.indexOf('+');
    return plus < 0 ? '0' : version.substring(plus + 1);
  }

  static YamlMap _loadPubspec() {
    final file = File('pubspec.yaml');
    if (!file.existsSync()) {
      stderr.writeln('pubspec.yaml 不存在(请在项目根目录运行)');
      exit(1);
    }
    final loaded = loadYaml(file.readAsStringSync());
    if (loaded is! YamlMap) {
      stderr.writeln('pubspec.yaml 解析失败');
      exit(1);
    }
    return loaded;
  }

  /// Reads the `## <tag>` section of CHANGELOG.md (up to the next `##`
  /// heading).
  ///
  /// A prerelease tag (e.g. `v1.1.0-beta`) prefers the full section
  /// `## v1.1.0-beta` and falls back to the major-version section
  /// `## v1.1.0` when missing (users write one set of notes).
  static String _readChangelogSection(String tag) {
    final file = File('CHANGELOG.md');
    if (!file.existsSync()) {
      stderr.writeln('CHANGELOG.md 不存在,请先补充 $tag 的更新说明');
      exit(1);
    }
    final lines = file.readAsLinesSync();
    final sectionStart = _findSectionStart(lines, '## $tag') ??
        _findSectionStart(lines, '## ${_stripPrereleaseSuffix(tag)}');
    if (sectionStart == null) {
      stderr.writeln(
        'CHANGELOG.md 缺少 "$tag" 或 "## ${_stripPrereleaseSuffix(tag)}" 段,'
        '请先补充更新说明',
      );
      exit(1);
    }
    final section = <String>[];
    for (var index = sectionStart; index < lines.length; index += 1) {
      if (lines[index].startsWith('## ')) break;
      section.add(lines[index]);
    }
    final notes = section.join('\n').trim();
    if (notes.isEmpty) {
      stderr.writeln(
        'CHANGELOG.md 的 "## $tag" 段为空,请补充更新说明',
      );
      exit(1);
    }
    return notes;
  }

  /// Finds the line in [lines] exactly matching [heading] and returns the
  /// index of the following line.
  static int? _findSectionStart(List<String> lines, String heading) {
    for (var index = 0; index < lines.length; index += 1) {
      if (lines[index].trim() == heading) {
        return index + 1;
      }
    }
    return null;
  }

  static Map<String, String> _parseArgs(List<String> args) {
    final options = <String, String>{};
    for (var index = 0; index < args.length; index += 2) {
      if (index + 1 < args.length && args[index].startsWith('--')) {
        options[args[index]] = args[index + 1];
      }
    }
    return options;
  }
}

Future<void> main(List<String> args) => MakeUpdateManifest.run(args);

