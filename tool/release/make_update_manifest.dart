/// 生成更新清单 `latest.yaml` 与 GitHub Release 说明 `release_notes.md`。
///
/// 发布流水线(`.github/workflows/release.yml`)在打完 zip 后调用:
///
/// ```bash
/// dart run tool/release/make_update_manifest.dart \
///   --zip foxy-1.1.0.zip --tag v1.1.0 \
///   --out latest.yaml --notes-out release_notes.md \
///   [--existing latest.yaml]
/// ```
///
/// 数据来源:
/// - 版本:`pubspec.yaml` 的 `version` 字段(与 `--tag` 主版本必须一致);
/// - 更新说明:`CHANGELOG.md` 中 `## <tag>` 段(预发布 tag 回退主版本段);
/// - 校验值:zip 文件的 SHA-256 与字节数。
///
/// 清单结构(YAML,releases 数组保留最近若干版本,最新在前):
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
///       更新说明
///     releasedAt: 2026-08-02T...
/// ```
///
/// `--existing` 传入上一版清单时,会合并保留最近 [kKeepReleases] 条
/// (同 version+buildNumber 的旧条目被替换);缺省或解析失败则只写当前条。
/// 结构与应用侧 `UpdateManifestInfo.fromMap` 对齐
/// (`lib/infrastructure/update/update_service.dart`)。
library;

import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:yaml/yaml.dart';

const _repo = 'CalsRanna/foxy';
const _appId = 'com.calsranna.foxy';

/// 清单保留的 release 条数上限。
const kKeepReleases = 3;

Future<void> main(List<String> args) async {
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

  // 1. 版本:pubspec 与 tag 主版本必须一致(单事实来源)。
  //    tag 可带预发布后缀(如 v1.1.0-beta),该后缀不进入 pubspec,仅标记
  //    测试发布:应用侧据此跳过预发布更新(见 update_service.dart 的
  //    `UpdateManifestInfo.isPrerelease`)。
  final version = _readPubspecVersion();
  final mainTag = _stripPrereleaseSuffix(tag);
  if (!mainTag.startsWith('v') || mainTag.substring(1) != version) {
    stderr.writeln('tag($tag) 主版本与 pubspec 版本($version)不一致,拒绝生成');
    exit(1);
  }
  final isPrerelease = mainTag != tag;
  final buildNumber = _readPubspecBuildNumber();

  // 2. 更新说明:CHANGELOG.md 的 `## <tag>` 段(预发布回退主版本段)。
  final notes = _readChangelogSection(tag);

  // 3. zip 校验值。
  final zipFile = File(zipPath);
  if (!await zipFile.exists()) {
    stderr.writeln('zip 不存在: $zipPath');
    exit(1);
  }
  final sha256Hex = (await sha256.bind(zipFile.openRead()).first).bytes
      .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
      .join();
  final sizeBytes = await zipFile.length();

  // 4. 合并历史 release(同 version+buildNumber 替换,保留最近 N 条)。
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
  final kept = releases.take(kKeepReleases).toList();

  // 5. 写 latest.yaml。
  await File(outPath).writeAsString(_dumpYaml(kept));

  // 6. 写 GitHub Release 说明(可选)。
  if (notesOutPath != null) {
    await File(notesOutPath).writeAsString('## Foxy $version\n\n$notes');
  }

  stdout.writeln('latest.yaml 已生成: version=$version build=$buildNumber '
      'isPrerelease=$isPrerelease releases=${kept.length} '
      'size=$sizeBytes sha256=${sha256Hex.substring(0, 12)}…');
}

/// 读取现有清单的 releases,排除与当前 (version, buildNumber) 相同的条目。
///
/// 解析失败(文件损坏/结构不符)返回空列表——宁可用只有当前条目的清单,
/// 也不让发布中断。
List<Map<String, Object?>> _readExistingReleases(
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
        continue; // 同版本重复发布:替换旧条目。
      }
      result.add(_stringifyKeys(item));
    }
    return result;
  } catch (error) {
    stderr.writeln('解析现有清单失败,仅保留当前条目: $error');
    return const [];
  }
}

/// 把 YamlMap 的键统一为 String(loadYaml 可能返回 dynamic 键)。
Map<String, Object?> _stringifyKeys(Map item) {
  return {
    for (final entry in item.entries)
      if (entry.key is String) entry.key: entry.value,
  };
}

/// 输出 YAML 清单(结构见文件头注释)。
String _dumpYaml(List<Map<String, Object?>> releases) {
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
    // 块标量 `|-`:多行说明,strip 尾部换行,内容缩进 6 空格。
    buffer.writeln('    notes: |-');
    for (final line in (release['notes'] as String).split('\n')) {
      buffer.writeln('      $line');
    }
    buffer.writeln('    releasedAt: ${release['releasedAt']}');
  }
  return buffer.toString();
}

/// 去掉 tag 的预发布后缀:`v1.1.0-beta` → `v1.1.0`。
///
/// 预发布后缀为 `-` 后跟字母数字/点/连字符(如 `-beta`、`-rc.1`)。
/// 不含后缀时原样返回。
String _stripPrereleaseSuffix(String tag) {
  final dash = tag.indexOf('-');
  if (dash < 0) return tag;
  final suffix = tag.substring(dash + 1);
  if (suffix.isEmpty || !RegExp(r'^[A-Za-z0-9.\-]+$').hasMatch(suffix)) {
    return tag;
  }
  return tag.substring(0, dash);
}

String _readPubspecVersion() {
  final pubspec = _loadPubspec();
  final version = pubspec['version'];
  if (version is! String) {
    stderr.writeln('pubspec.yaml 缺少 version 字段');
    exit(1);
  }
  final plus = version.indexOf('+');
  return plus < 0 ? version : version.substring(0, plus);
}

String _readPubspecBuildNumber() {
  final pubspec = _loadPubspec();
  final version = pubspec['version'];
  if (version is! String) {
    stderr.writeln('pubspec.yaml 缺少 version 字段');
    exit(1);
  }
  final plus = version.indexOf('+');
  return plus < 0 ? '0' : version.substring(plus + 1);
}

YamlMap _loadPubspec() {
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

/// 读取 CHANGELOG.md 中 `## <tag>` 段(到下一个 `##` 标题为止)。
///
/// 预发布 tag(如 `v1.1.0-beta`)优先匹配完整段 `## v1.1.0-beta`,
/// 缺失时回退到主版本段 `## v1.1.0`(用户只需写一份说明)。
String _readChangelogSection(String tag) {
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

/// 在 [lines] 中查找与 [heading] 完全匹配的标题行,返回其下一行下标。
int? _findSectionStart(List<String> lines, String heading) {
  for (var index = 0; index < lines.length; index += 1) {
    if (lines[index].trim() == heading) {
      return index + 1;
    }
  }
  return null;
}

Map<String, String> _parseArgs(List<String> args) {
  final options = <String, String>{};
  for (var index = 0; index < args.length; index += 2) {
    if (index + 1 < args.length && args[index].startsWith('--')) {
      options[args[index]] = args[index + 1];
    }
  }
  return options;
}
