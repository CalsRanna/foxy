/// Foxy 更新辅助程序(独立编译,不依赖 Flutter 运行时)。
///
/// 编译:`dart compile exe tool/updater/updater_main.dart -o <Release>/foxy_updater.exe`
///
/// 执行流程:
/// 1. 若自身不在 `%TEMP%` 下,先自拷贝到 `%TEMP%` 并以相同参数重启,旧实例退出
///    (避免替换运行中的自身);
/// 2. 清理 `%TEMP%` 下历史辅助程序副本;
/// 3. 轮询等待主程序进程退出(`--wait-pid`,上限 10 分钟,超时则放弃交换直接重启应用);
/// 4. 用 [UpdateSwapper.applyUpdate] 把新版本镜像到应用目录(保留 config.yaml
///    与 data/icon/,见 [UpdateSwapper.preservedRelPaths]);
/// 5. 删除更新临时目录;
/// 6. 以应用目录为工作目录重启主程序。
///
/// 全程诊断日志写入 `%TEMP%\foxy_updater.log`(英文)。
library;

import 'dart:io';

import 'package:foxy/infrastructure/update/update_swapper.dart';
import 'package:path/path.dart' as p;

/// 日志路径:`%TEMP%\foxy_updater.log`。
final String updaterLogPath =
    p.join(Directory.systemTemp.path, 'foxy_updater.log');

/// 等待主程序退出的上限。
const kWaitTimeout = Duration(minutes: 10);

Future<void> main(List<String> args) async {
  final options = _parseArgs(args);
  final log = _Logger(updaterLogPath);

  final appDir = options['--app-dir'];
  final updateDir = options['--update-dir'];
  final waitPid = int.tryParse(options['--wait-pid'] ?? '');
  final appExe = options['--app-exe'] ?? kAppExeName;
  if (appDir == null || updateDir == null || waitPid == null) {
    log.e(
      'Usage: foxy_updater --app-dir <dir> --update-dir <dir> '
      '--wait-pid <pid> [--app-exe <name>]',
    );
    exit(2);
  }

  // 1. 自拷贝到 %TEMP% 后重启,避免替换运行中的自身。
  final tempDir = Directory.systemTemp;
  if (!_isInDir(Platform.resolvedExecutable, tempDir.path)) {
    final copyPath = p.join(tempDir.path, 'foxy_updater_$pid.exe');
    log.i('Self-copy to $copyPath');
    await File(Platform.resolvedExecutable).copy(copyPath);
    await Process.start(copyPath, args);
    return;
  }

  // 2. 清理历史副本(保留自身)。
  await _cleanupStaleCopies(log);

  // 3. 等待主程序退出。
  log.i('Waiting for main process (pid=$waitPid) to exit');
  final exited = await _waitForProcessExit(waitPid, kWaitTimeout);
  if (!exited) {
    log.e('Timed out waiting for main process; skipping swap');
    await _relaunchApp(log, appDir, appExe);
    exit(3);
  }

  // 4. 镜像替换。
  log.i('Applying update from $updateDir to $appDir');
  final result = await UpdateSwapper.applyUpdate(
    appDir: Directory(appDir),
    payloadRoot: Directory(updateDir),
  );
  if (result.hasFailures) {
    final detail = result.failures.map((failure) => failure.toString()).join('; ');
    log.e('Swap completed with failures: $detail');
  } else {
    log.i('Swap completed');
  }

  // 5. 删除更新临时目录。
  await _deleteWithRetry(Directory(p.join(appDir, kUpdateTempDirName)), log);

  // 6. 重启主程序。
  await _relaunchApp(log, appDir, appExe);
  log.i('Updater finished');
}

/// 解析 `--key value` 形式参数。
Map<String, String> _parseArgs(List<String> args) {
  final options = <String, String>{};
  for (var index = 0; index < args.length; index += 2) {
    if (index + 1 < args.length && args[index].startsWith('--')) {
      options[args[index]] = args[index + 1];
    }
  }
  return options;
}

/// [path] 是否位于 [dirPath] 下。
bool _isInDir(String path, String dirPath) {
  final normalized = p.normalize(path).toLowerCase();
  final dir = p.normalize(dirPath).toLowerCase();
  return p.dirname(normalized) == dir;
}

/// 轮询 tasklist 等待进程退出;返回是否在超时前退出。
Future<bool> _waitForProcessExit(int targetPid, Duration timeout) async {
  final deadline = DateTime.now().add(timeout);
  final pidPattern = RegExp('(^|\\s)$targetPid(\\s|\$)');
  while (DateTime.now().isBefore(deadline)) {
    try {
      final result = await Process.run(
        'tasklist',
        ['/FI', 'PID eq $targetPid', '/NH'],
      );
      final alive =
          result.exitCode == 0 && pidPattern.hasMatch(result.stdout.toString());
      if (!alive) return true;
    } catch (error) {
      // tasklist 调用失败时保守等待,不提前交换。
    }
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
  return false;
}

/// 重启主程序,以应用目录为工作目录。
Future<void> _relaunchApp(_Logger log, String appDir, String appExe) async {
  final exePath = p.join(appDir, appExe);
  log.i('Relaunching $exePath');
  try {
    await Process.start(exePath, const [], workingDirectory: appDir);
  } catch (error) {
    log.e('Failed to relaunch $exePath: $error');
  }
}

/// 清理 `%TEMP%` 下历史 `foxy_updater_*.exe` 副本(保留自身)。
Future<void> _cleanupStaleCopies(_Logger log) async {
  final current = Platform.resolvedExecutable;
  try {
    final entities = await Directory.systemTemp.list().toList();
    for (final entity in entities) {
      if (entity is! File) continue;
      final name = p.basename(entity.path);
      if (name.startsWith('foxy_updater_') && entity.path != current) {
        try {
          await entity.delete();
          log.i('Cleaned up stale copy $name');
        } catch (error) {
          log.e('Failed to clean $name: $error');
        }
      }
    }
  } catch (error) {
    log.e('Failed to list temp dir: $error');
  }
}

/// 删除目录(重试 3 次,间隔 300ms)。
Future<void> _deleteWithRetry(Directory dir, _Logger log) async {
  for (var attempt = 0; attempt < 3; attempt += 1) {
    try {
      if (await dir.exists()) {
        await dir.delete(recursive: true);
      }
      log.i('Removed ${dir.path}');
      return;
    } catch (error) {
      if (attempt == 2) {
        log.e('Failed to remove ${dir.path}: $error');
      }
      await Future<void>.delayed(const Duration(milliseconds: 300));
    }
  }
}

/// 追加写日志。
class _Logger {
  _Logger(this.path);

  final String path;

  void i(String message) => _write('INFO', message);

  void e(String message) => _write('ERROR', message);

  void _write(String level, String message) {
    try {
      File(path).writeAsStringSync(
        '[${DateTime.now().toIso8601String()}][$level] $message\n',
        mode: FileMode.append,
      );
    } catch (_) {
      // 日志失败不影响更新流程。
    }
  }
}
