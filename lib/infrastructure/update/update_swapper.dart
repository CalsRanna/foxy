/// 便携式更新文件交换核心(纯 Dart,不依赖 Flutter)。
///
/// 主程序无法在运行时替换自身(Windows 锁定运行中的 exe),因此更新流程是:
/// 主程序下载并解压新版本到 `<应用目录>/.update_tmp/` → 启动 `foxy_updater.exe`
/// 并退出 → 辅助程序等待主进程结束后调用 [UpdateSwapper.applyUpdate] 完成
/// 镜像替换 → 重启应用。
///
/// 运行目录里有两类用户数据必须保留(见 [preservedRelPaths]):
/// - `config.yaml`:数据库连接与目录配置(`lib/infrastructure/config/config_util.dart`);
/// - `data/icon/`:已提取的游戏图标缓存(`lib/infrastructure/game_asset/game_icon_paths.dart`)。
/// 注意 flutter 自身的 `data/flutter_assets`、`data/icudtl.dat` 与图标缓存同在
/// `data/` 下,只能排除 `data/icon/` 子树,不能整目录排除。
library;

import 'dart:io';

/// 更新临时目录名(位于应用目录下,交换完成后删除)。
const kUpdateTempDirName = '.update_tmp';

/// 更新辅助程序文件名(随应用一起分发,位于应用目录下)。
const kUpdaterExeName = 'foxy_updater.exe';

/// 应用主程序文件名。
const kAppExeName = 'foxy.exe';

/// 单文件操作失败记录;整体交换不中断,保证应用可用。
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

/// 把新版本 payload 镜像到应用目录,保留用户数据。
class UpdateSwapper {
  /// 相对路径(正斜杠分隔)保留清单:更新时不删除、不覆盖。
  ///
  /// 这些是用户生成的数据,永远不会出现在发布 zip 中。
  static const List<String> preservedRelPaths = [
    'config.yaml',
    'data/icon',
  ];

  /// [relPath] 是否命中保留清单(自身或子树)。
  static bool isPreserved(String relPath) {
    final normalized = _normalize(relPath);
    return preservedRelPaths.any(
      (preserved) =>
          normalized == preserved || normalized.startsWith('$preserved/'),
    );
  }

  /// 把 [payloadRoot] 的内容镜像应用到 [appDir]:
  ///
  /// - 拷贝 payload 全部文件到应用目录(保留清单除外);
  /// - 删除应用目录中 payload 不存在的文件(保留清单与更新临时目录除外);
  /// - 单文件失败记录到 [UpdateSwapResult.failures],不中断整体流程。
  ///
  /// 返回失败清单;调用方应把失败写入日志(交换不完整时应用仍可启动,
  /// 下次更新会自愈)。
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

    // 1. 拷贝 payload → 应用目录(保留清单跳过)。
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

    // 2. 删除应用目录中的残留文件(payload 没有的、非保留、非更新临时目录)。
    final pendingDeletes = <File>[];
    await _walk(
      appDir,
      onFile: (file, relPath) {
        if (isPreserved(relPath)) return;
        if (relPath == kUpdateTempDirName ||
            relPath.startsWith('$kUpdateTempDirName/')) {
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

    // 3. 清理空目录(payload 不含的目录;保留清单内的目录不动)。
    await _pruneEmptyDirs(appDir, payloadFiles);

    return UpdateSwapResult(failures: failures);
  }

  /// 遍历 [root] 下所有文件,[onFile] 收到文件与相对 root 的正斜杠路径。
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

  /// 拷贝文件,失败(如占用)按 [maxRetries] 重试,间隔 300ms。
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

  /// 删除文件,失败重试(同上)。
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

  /// 删除 payload 未覆盖到的空目录(非保留、非更新临时目录)。
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
      if (relPath == kUpdateTempDirName) continue;
      final hasPayloadFile = payloadFiles.any(
        (path) => path == relPath || path.startsWith('$relPath/'),
      );
      if (hasPayloadFile) continue;
      try {
        if (await dir.exists() && await dir.list().isEmpty) {
          await dir.delete();
        }
      } catch (_) {
        // 目录清理失败不影响整体交换。
      }
    }
  }

  static String _join(String a, String b) =>
      '$a/${b.replaceAll(RegExp(r'[/\\]+'), '/')}';

  /// 相对路径,统一正斜杠,去掉首尾分隔符。
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
