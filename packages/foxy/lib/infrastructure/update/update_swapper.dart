/// Core of the portable-update file swap (pure Dart, no Flutter
/// dependency).
///
/// The main program cannot replace itself at runtime (Windows locks the
/// running exe), so the update flow is: the main program downloads and
/// extracts the new version into `<app dir>/.update_tmp/` → launches
/// `foxy_updater.exe` and exits → the helper waits for the main process to
/// end, calls [UpdateSwapper.applyUpdate] to mirror-replace, then restarts
/// the app.
///
/// Two kinds of user data in the run directory must survive (see
/// [preservedRelPaths]):
/// - `config.yaml`: database connection and directory config
///   (`lib/infrastructure/config/config_util.dart`);
/// - `data/icon/`: the extracted game-icon cache
///   (`lib/infrastructure/game_asset/game_icon_paths.dart`).
/// Note that Flutter's own `data/flutter_assets` and `data/icudtl.dat`
/// share `data/` with the icon cache, so only the `data/icon/` subtree can
/// be excluded, never the whole directory.
library;

import 'dart:io';

import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:path/path.dart' as p;

/// Records per-file operation failures; the overall swap is not aborted,
/// keeping the app usable.
class UpdateSwapFailure {
  const UpdateSwapFailure(this.path, this.message);

  final String path;
  final String message;

  @override
  String toString() => '$path: $message';
}

class UpdateSwapResult {
  const UpdateSwapResult({this.failures = const []});

  final List<UpdateSwapFailure> failures;

  bool get hasFailures => failures.isNotEmpty;
}

/// Mirrors the new-version payload into the app directory, preserving user
/// data.
class UpdateSwapper {
  /// Update temp directory name (under the app directory; deleted after
  /// the swap completes).
  static const tempDirName = '.update_tmp';

  /// Update-helper program file name (distributed with the app, under the
  /// app directory).
  static const updaterExeName = 'foxy_updater.exe';

  /// App main-program file name.
  static const appExeName = 'foxy.exe';

  /// Preserve list of relative paths (forward-slash separated): never
  /// deleted or overwritten during an update.
  ///
  /// These are user-generated data and never appear in the release zip.
  static const List<String> preservedRelPaths = ['config.yaml', 'data/icon'];

  /// Whether [relPath] hits the preserve list (itself or a subtree).
  static bool isPreserved(String relPath) {
    final normalized = _normalize(relPath);
    return preservedRelPaths.any(
      (preserved) =>
          normalized == preserved || normalized.startsWith('$preserved/'),
    );
  }

  /// Cleans up a leftover `.update_tmp/` directory from an interrupted
  /// update (does not block startup).
  ///
  /// Update flow: download and extract into `.update_tmp/` → after restart
  /// `foxy_updater.exe` swaps and deletes it; if the app is force-killed
  /// before the swap, this cleanup covers the leftovers and the next update
  /// check rediscovers the new version.
  static void cleanupStaleTemp() {
    final dir = Directory(p.join(Directory.current.path, tempDirName));
    if (!dir.existsSync()) return;
    Future<void>.delayed(Duration.zero, () async {
      try {
        if (await dir.exists()) {
          await dir.delete(recursive: true);
        }
      } catch (error) {
        LoggerUtil.instance.w('清理更新临时目录失败: $error');
      }
    });
  }

  /// Mirrors the content of [payloadRoot] onto [appDir]:
  ///
  /// - Copies every payload file into the app directory (except preserved
  ///   paths);
  /// - Deletes files in the app directory absent from the payload (except
  ///   preserved paths and the update temp directory);
  /// - Records per-file failures in [UpdateSwapResult.failures] without
  ///   interrupting the overall flow.
  ///
  /// Returns the failure list; callers should log the failures (the app can
  /// still start with an incomplete swap, and the next update self-heals).
  static Future<UpdateSwapResult> applyUpdate({
    required Directory appDir,
    required Directory payloadRoot,
    int maxRetries = 3,
  }) async {
    final failures = <UpdateSwapFailure>[];
    final payloadFiles = <String>{};
    final payloadList = <File>[];
    await _walk(
      payloadRoot,
      onFile: (file, relPath) {
        payloadFiles.add(relPath);
        payloadList.add(file);
      },
    );

    // 1. Copy payload → app directory (skip preserved paths).
    for (final file in payloadList) {
      final relPath = _relative(file.path, payloadRoot.path);
      final destPath = _join(appDir.path, relPath);
      if (isPreserved(relPath)) continue;
      try {
        await _copyWithRetry(file, File(destPath), maxRetries);
      } catch (error) {
        failures.add(UpdateSwapFailure(destPath, 'copy failed: $error'));
      }
    }

    // 2. Delete leftover files in the app directory (absent from payload,
    //    not preserved, not the update temp directory).
    final pendingDeletes = <File>[];
    await _walk(
      appDir,
      onFile: (file, relPath) {
        if (isPreserved(relPath)) return;
        if (relPath == tempDirName || relPath.startsWith('$tempDirName/')) {
          return;
        }
        if (!payloadFiles.contains(relPath)) {
          pendingDeletes.add(file);
        }
      },
    );
    for (final file in pendingDeletes) {
      try {
        await _deleteWithRetry(file, maxRetries);
      } catch (error) {
        failures.add(UpdateSwapFailure(file.path, 'delete failed: $error'));
      }
    }

    // 3. Clean up empty directories (not in payload; directories inside
    //    the preserve list are untouched).
    await _pruneEmptyDirs(appDir, payloadFiles);

    return UpdateSwapResult(failures: failures);
  }

  /// Walks all files under [root]; [onFile] receives each file and its
  /// forward-slash path relative to root.
  static Future<void> _walk(
    Directory root, {
    required void Function(File file, String relPath) onFile,
  }) async {
    final entities = await root.list(recursive: true).toList();
    for (final entity in entities) {
      if (entity is File) {
        onFile(entity, _relative(entity.path, root.path));
      }
    }
  }

  /// Copies a file, retrying on failure (e.g. locked) up to [maxRetries]
  /// times with 300ms pauses.
  static Future<void> _copyWithRetry(
    File source,
    File dest,
    int maxRetries,
  ) async {
    await dest.parent.create(recursive: true);
    for (var attempt = 0; ; attempt += 1) {
      try {
        await source.copy(dest.path);
        return;
      } catch (error) {
        if (attempt >= maxRetries) rethrow;
        await Future<void>.delayed(const Duration(milliseconds: 300));
      }
    }
  }

  /// Deletes a file, retrying on failure (same as above).
  static Future<void> _deleteWithRetry(File file, int maxRetries) async {
    for (var attempt = 0; ; attempt += 1) {
      try {
        if (await file.exists()) {
          await file.delete();
        }
        return;
      } catch (error) {
        if (attempt >= maxRetries) rethrow;
        await Future<void>.delayed(const Duration(milliseconds: 300));
      }
    }
  }

  /// Deletes empty directories not covered by the payload (not preserved,
  /// not the update temp directory).
  static Future<void> _pruneEmptyDirs(
    Directory appDir,
    Set<String> payloadFiles,
  ) async {
    final entities = await appDir.list(recursive: true).toList();
    final dirs = entities.whereType<Directory>().toList()
      ..sort((a, b) => b.path.length.compareTo(a.path.length));
    for (final dir in dirs) {
      final relPath = _relative(dir.path, appDir.path);
      if (isPreserved(relPath)) continue;
      if (relPath == tempDirName) continue;
      final hasPayloadFile = payloadFiles.any(
        (path) => path == relPath || path.startsWith('$relPath/'),
      );
      if (hasPayloadFile) continue;
      try {
        if (await dir.exists() && await dir.list().isEmpty) {
          await dir.delete();
        }
      } catch (_) {
        // A failed directory cleanup does not affect the overall swap.
      }
    }
  }

  static String _join(String a, String b) =>
      '$a/${b.replaceAll(RegExp(r'[/\\]+'), '/')}';

  /// Relative path, normalized to forward slashes with leading/trailing
  /// separators stripped.
  static String _relative(String path, String root) {
    var rel = path.substring(root.length);
    rel = rel.replaceAll('\\', '/');
    while (rel.startsWith('/')) {
      rel = rel.substring(1);
    }
    return rel;
  }

  static String _normalize(String relPath) {
    var normalized = relPath.replaceAll('\\', '/');
    while (normalized.startsWith('/')) {
      normalized = normalized.substring(1);
    }
    while (normalized.endsWith('/')) {
      normalized = normalized.substring(0, normalized.length - 1);
    }
    return normalized;
  }
}
