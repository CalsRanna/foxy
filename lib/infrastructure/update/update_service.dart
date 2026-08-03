/// 更新服务:拉取更新清单、版本比较、下载校验(SHA-256)、解压。
///
/// 分发方式为便携 zip(无安装器):发布流程把 Release 文件夹打成 zip 并随
/// `latest.yaml` 一起挂在 GitHub Release 附件上,本服务从
/// `releases/latest/download/latest.yaml` 拉取清单(302 跟随由 http 包处理),
/// 下载 zip 校验后解压到应用目录的 `.update_tmp/`,再由辅助程序
/// (`tool/updater/updater_main.dart`)在主程序退出后完成文件交换。
library;

import 'dart:async';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:crypto/crypto.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/infrastructure/update/update_swapper.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

/// 更新清单 `latest.yaml`:发布流水线生成,YAML 结构见
/// `tool/release/make_update_manifest.dart`。
class UpdateManifestInfo {
  const UpdateManifestInfo({
    required this.version,
    required this.buildNumber,
    required this.zipUrl,
    required this.sizeBytes,
    required this.sha256,
    required this.notes,
    this.isPrerelease = false,
  });

  /// 新版本号(与 pubspec 的 `version` 一致,不含 build)。
  final String version;

  /// 新版本 build 号(与 pubspec 的 `+N` 一致)。
  final String buildNumber;

  /// 是否预发布(测试)版本:发布 tag 带 `-alpha`/`-beta`/`-rc` 等后缀时由
  /// 发布流水线写入清单,应用侧据此跳过,不推送给正式用户。
  final bool isPrerelease;

  /// zip 下载地址(指向版本化的 Release 附件)。
  final Uri zipUrl;

  /// zip 字节数。
  final int sizeBytes;

  /// zip 的 SHA-256(小写十六进制)。
  final String sha256;

  /// 中文更新说明。
  final String notes;

  /// 从 YAML/JSON 解析出的 release 条目 Map 构建。
  ///
  /// 字段缺失或类型不符抛 [FormatException];`isPrerelease` 可缺省
  /// (兼容旧清单),缺省视为正式版。
  factory UpdateManifestInfo.fromMap(Map<dynamic, dynamic> map) {
    final version = map['version'];
    final buildNumber = map['buildNumber'];
    final zipUrl = map['zipUrl'];
    final sizeBytes = map['sizeBytes'];
    final sha256 = map['sha256'];
    final notes = map['notes'];
    final isPrerelease = map['isPrerelease'];
    if (version is! String ||
        buildNumber is! String ||
        zipUrl is! String ||
        sizeBytes is! int ||
        sha256 is! String ||
        notes is! String ||
        (isPrerelease != null && isPrerelease is! bool)) {
      throw const FormatException('update manifest release invalid');
    }
    return UpdateManifestInfo(
      version: version,
      buildNumber: buildNumber,
      isPrerelease: isPrerelease == true,
      zipUrl: Uri.parse(zipUrl),
      sizeBytes: sizeBytes,
      sha256: sha256.toLowerCase(),
      notes: notes,
    );
  }
}

/// 更新检查结果。
sealed class UpdateCheckResult {
  const UpdateCheckResult();
}

/// 发现可更新的新版本。
final class UpdateAvailable extends UpdateCheckResult {
  const UpdateAvailable(this.update);

  final UpdateManifestInfo update;
}

/// 当前已是最新版本。
final class UpToDate extends UpdateCheckResult {
  const UpToDate();
}

/// 下载取消令牌。
class UpdateCancelToken {
  bool _canceled = false;

  /// 是否已请求取消。
  bool get isCanceled => _canceled;

  /// 请求取消(下载会在下一个数据块处停止并清理半成品)。
  void cancel() => _canceled = true;
}

class UpdateService {
  UpdateService({http.Client? client, String? manifestUrl})
      : _client = client ?? http.Client(),
        _manifestUrl = Uri.parse(manifestUrl ?? defaultManifestUrl);

  /// 清单地址:GitHub Releases 附件,`latest` 恒指向最新发布。
  static const defaultManifestUrl =
      'https://github.com/CalsRanna/foxy/releases/latest/download/latest.yaml';

  /// 期望的清单 appId(发布流水线写入,防清单地址配错)。
  static const expectedAppId = 'com.calsranna.foxy';

  static const _requestTimeout = Duration(seconds: 30);

  /// 下载正文相邻数据块之间的闲置超时,防止连接停滞时下载永久挂起。
  static const _chunkTimeout = Duration(seconds: 30);

  final http.Client _client;
  final Uri _manifestUrl;

  /// 检查是否有新版本。
  ///
  /// [installedVersion] / [installedBuildNumber] 供测试注入,缺省读
  /// `package_info_plus`。失败抛 [UpdateException]。
  Future<UpdateCheckResult> checkForUpdates({
    String? installedVersion,
    String? installedBuildNumber,
  }) async {
    try {
      final response = await _client.get(_manifestUrl).timeout(_requestTimeout);
      if (response.statusCode != 200) {
        throw UpdateException(
          UpdateErrorKind.network,
          'Update manifest fetch failed: HTTP ${response.statusCode}',
        );
      }
      final update = _parseManifest(response.body);

      String currentVersion;
      String currentBuild;
      if (installedVersion != null) {
        currentVersion = installedVersion;
        currentBuild = installedBuildNumber ?? '';
      } else {
        final info = await PackageInfo.fromPlatform();
        currentVersion = info.version;
        currentBuild = info.buildNumber;
      }

      if (_isNewer(update, currentVersion, currentBuild)) {
        return UpdateAvailable(update);
      }
      return const UpToDate();
    } on UpdateException {
      rethrow;
    } on TimeoutException catch (error) {
      throw UpdateException(
        UpdateErrorKind.network,
        'Update manifest fetch timed out: $error',
      );
    } on SocketException catch (error) {
      throw UpdateException(
        UpdateErrorKind.network,
        'Update manifest fetch failed: $error',
      );
    } on http.ClientException catch (error) {
      throw UpdateException(
        UpdateErrorKind.network,
        'Update manifest fetch failed: $error',
      );
    } on FormatException catch (error) {
      throw UpdateException(
        UpdateErrorKind.invalidManifest,
        'Update manifest parse failed: $error',
      );
    }
  }

  /// 下载、校验并解压新版本到 [appDir] 的 `.update_tmp/`。
  ///
  /// [onProgress] 收到 0..1 下载进度;返回实际 payload 根目录(zip 若
  /// 只有一个顶层目录——压缩了文件夹本身——返回该目录,否则返回
  /// `.update_tmp/`)。失败时清理半成品并抛 [UpdateException]。
  Future<Directory> prepareUpdate(
    UpdateManifestInfo update, {
    required Directory appDir,
    void Function(double fraction)? onProgress,
    UpdateCancelToken? cancelToken,
  }) async {
    final zipFile = await downloadZip(
      update,
      onProgress: onProgress,
      cancelToken: cancelToken,
    );
    try {
      final updateDir = Directory(p.join(appDir.path, kUpdateTempDirName));
      if (await updateDir.exists()) {
        await updateDir.delete(recursive: true);
      }
      await updateDir.create(recursive: true);
      await _extractZip(zipFile, updateDir);
      return resolvePayloadRoot(updateDir);
    } on UpdateException {
      rethrow;
    } on FileSystemException catch (error) {
      throw UpdateException(
        UpdateErrorKind.fileSystem,
        'Update extract failed: $error',
      );
    } finally {
      await _deleteQuietly(zipFile);
    }
  }

  /// 下载 zip 到系统临时目录并校验大小与 SHA-256。
  ///
  /// [onProgress] 收到 0..1 下载进度;校验失败时删除半成品并抛
  /// [UpdateException]。返回已校验的 zip 文件。
  Future<File> downloadZip(
    UpdateManifestInfo update, {
    void Function(double fraction)? onProgress,
    UpdateCancelToken? cancelToken,
  }) async {
    final file = File(
      p.join(Directory.systemTemp.path, 'foxy_update_${update.version}.zip'),
    );
    IOSink? sink;
    try {
      final request = http.Request('GET', update.zipUrl);
      final response = await _client.send(request).timeout(_requestTimeout);
      if (response.statusCode != 200) {
        throw UpdateException(
          UpdateErrorKind.network,
          'Update zip download failed: HTTP ${response.statusCode}',
        );
      }
      final total = response.contentLength;
      sink = file.openWrite();
      var downloaded = 0;
      // 正文流逐块闲置超时:仅对响应头设超时不够,连接中途停滞时
      // 下载会永久挂起且取消令牌永远等不到下一个 chunk。
      await for (final chunk in response.stream.timeout(_chunkTimeout)) {
        if (cancelToken?.isCanceled ?? false) {
          throw const UpdateException(
            UpdateErrorKind.canceled,
            'Update download canceled by user',
          );
        }
        sink.add(chunk);
        downloaded += chunk.length;
        if (total != null && total > 0) {
          onProgress?.call(downloaded / total);
        }
      }
      await sink.flush();
      await sink.close();
      sink = null;

      final actualSize = await file.length();
      if (actualSize != update.sizeBytes) {
        await _deleteQuietly(file);
        throw UpdateException(
          UpdateErrorKind.verification,
          'Update zip size mismatch: expected ${update.sizeBytes}, got $actualSize',
        );
      }
      final digest = await sha256.bind(file.openRead()).first;
      final hex = digest.bytes
          .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
          .join();
      if (hex != update.sha256) {
        await _deleteQuietly(file);
        throw const UpdateException(
          UpdateErrorKind.verification,
          'Update zip SHA-256 mismatch',
        );
      }
      return file;
    } on UpdateException {
      await _disposeSink(sink);
      await _deleteQuietly(file);
      rethrow;
    } on TimeoutException catch (error) {
      await _disposeSink(sink);
      await _deleteQuietly(file);
      throw UpdateException(
        UpdateErrorKind.network,
        'Update zip download timed out: $error',
      );
    } on SocketException catch (error) {
      await _disposeSink(sink);
      await _deleteQuietly(file);
      throw UpdateException(
        UpdateErrorKind.network,
        'Update zip download failed: $error',
      );
    } on http.ClientException catch (error) {
      await _disposeSink(sink);
      await _deleteQuietly(file);
      throw UpdateException(
        UpdateErrorKind.network,
        'Update zip download failed: $error',
      );
    } on FileSystemException catch (error) {
      await _disposeSink(sink);
      await _deleteQuietly(file);
      throw UpdateException(
        UpdateErrorKind.fileSystem,
        'Update zip write failed: $error',
      );
    }
  }

  /// 解压 [zipFile] 到 [targetDir](zip-slip 防护由 archive 包的
  /// [extractArchiveToDisk] 内置处理)。
  static Future<void> _extractZip(File zipFile, Directory targetDir) async {
    final archive = ZipDecoder().decodeBytes(await zipFile.readAsBytes());
    await extractArchiveToDisk(archive, targetDir.path);
  }

  /// 解压产物若只有一个顶层目录(发布时压缩了文件夹本身),返回该目录
  /// 作为 payload 根,否则返回 [updateDir] 本身。
  static Directory resolvePayloadRoot(Directory updateDir) {
    final entities = updateDir.listSync(followLinks: false);
    final dirs = entities.whereType<Directory>().toList();
    final hasRootFile = entities.any((entity) => entity is File);
    if (!hasRootFile && dirs.length == 1) {
      return dirs.single;
    }
    return updateDir;
  }

  /// 新版本是否高于当前版本:主版本号比较,相同时 build 号数值决胜。
  ///
  /// 清单标记为预发布(`isPrerelease`,发布 tag 带 `-alpha`/`-beta`/`-rc`
  /// 后缀)时不视为更新:测试版本不推送给正式用户。当前已装预发布版本的
  /// 用户仍会收到后续正式版更新(正式版不标记为预发布)。
  static bool _isNewer(
    UpdateManifestInfo update,
    String installedVersion,
    String installedBuildNumber,
  ) {
    if (update.isPrerelease) {
      return false;
    }
    final current = _tryParseVersion(installedVersion);
    final latest = _tryParseVersion(update.version);
    if (current == null || latest == null) {
      // 版本号不可解析时退化为 build 号比较(两者都可解析才可能更新)。
      final currentBuild = int.tryParse(installedBuildNumber);
      final latestBuild = int.tryParse(update.buildNumber);
      return latestBuild != null &&
          currentBuild != null &&
          latestBuild > currentBuild;
    }
    if (latest > current) return true;
    if (latest == current) {
      final currentBuild = int.tryParse(installedBuildNumber) ?? 0;
      final latestBuild = int.tryParse(update.buildNumber) ?? 0;
      return latestBuild > currentBuild;
    }
    return false;
  }

  /// 解析 `latest.yaml` 清单:校验 appId,取 releases 第一条。
  ///
  /// 结构见 `tool/release/make_update_manifest.dart`;发布流水线保证
  /// 最新版本在最前,故取第一条即为最新可用更新。
  static UpdateManifestInfo _parseManifest(String body) {
    final decoded = loadYaml(body);
    if (decoded is! Map) {
      throw const UpdateException(
        UpdateErrorKind.invalidManifest,
        'Update manifest is not a YAML mapping',
      );
    }
    if (decoded['appId'] != expectedAppId) {
      throw UpdateException(
        UpdateErrorKind.invalidManifest,
        'Update manifest appId mismatch: ${decoded['appId']}',
      );
    }
    final releases = decoded['releases'];
    if (releases is! List || releases.isEmpty) {
      throw const UpdateException(
        UpdateErrorKind.invalidManifest,
        'Update manifest has no releases',
      );
    }
    final first = releases.first;
    if (first is! Map) {
      throw const UpdateException(
        UpdateErrorKind.invalidManifest,
        'Update manifest first release is not a mapping',
      );
    }
    try {
      return UpdateManifestInfo.fromMap(first);
    } on FormatException catch (error) {
      throw UpdateException(
        UpdateErrorKind.invalidManifest,
        'Update manifest release invalid: $error',
      );
    }
  }

  /// 解析版本号;解析失败返回 null。
  static Version? _tryParseVersion(String text) {
    try {
      return Version.parse(text);
    } on FormatException {
      return null;
    }
  }

  /// 关闭下载流,忽略关闭错误(半成品由 [UpdateException] 路径删除)。
  static Future<void> _disposeSink(IOSink? sink) async {
    if (sink == null) return;
    try {
      await sink.close();
    } catch (_) {
      // 关闭失败不影响后续清理。
    }
  }

  static Future<void> _deleteQuietly(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (_) {
      // 清理失败由系统临时目录兜底。
    }
  }
}
