/// Foxy update helper (compiled standalone, no Flutter runtime).
///
/// Build:
/// `dart compile exe tool/updater/updater_main.dart -o <Release>/foxy_updater.exe`
///
/// Execution flow:
/// 1. If not already under `%TEMP%`, self-copy to `%TEMP%` and restart
///    with the same arguments; the old instance exits (so the running
///    binary is never replaced in place);
/// 2. Clean up historical helper copies under `%TEMP%`;
/// 3. Poll-wait for the main process to exit (`--wait-pid`, up to 10
///    minutes; on timeout, skip the swap and restart the app directly);
/// 4. Use [UpdateSwapper.applyUpdate] to mirror the new version onto the
///    app directory (preserving config.yaml and data/icon/, see
///    [UpdateSwapper.preservedRelPaths]);
/// 5. Delete the update temp directory;
/// 6. Restart the main program with the app directory as its working
///    directory.
///
/// Diagnostic logs throughout are written to `%TEMP%\foxy_updater.log`
/// (English).
library;

import 'dart:io';

import 'package:foxy/infrastructure/update/update_swapper.dart';
import 'package:path/path.dart' as p;

abstract final class UpdaterMain {
  /// Log path: `%TEMP%\foxy_updater.log`.
  static final String updaterLogPath =
      p.join(Directory.systemTemp.path, 'foxy_updater.log');

  /// Cap on waiting for the main process to exit.
  static const waitTimeout = Duration(minutes: 10);

  static Future<void> run(List<String> args) async {
    final options = _parseArgs(args);
    final log = _Logger(updaterLogPath);

    final appDir = options['--app-dir'];
    final updateDir = options['--update-dir'];
    final waitPid = int.tryParse(options['--wait-pid'] ?? '');
    final appExe = options['--app-exe'] ?? UpdateSwapper.appExeName;
    if (appDir == null || updateDir == null || waitPid == null) {
      log.e(
        'Usage: foxy_updater --app-dir <dir> --update-dir <dir> '
        '--wait-pid <pid> [--app-exe <name>]',
      );
      exit(2);
    }

    // 1. Self-copy to %TEMP% and restart, avoiding replacement of the
    //    running binary.
    final tempDir = Directory.systemTemp;
    if (!_isInDir(Platform.resolvedExecutable, tempDir.path)) {
      final copyPath = p.join(tempDir.path, 'foxy_updater_$pid.exe');
      log.i('Self-copy to $copyPath');
      await File(Platform.resolvedExecutable).copy(copyPath);
      await Process.start(copyPath, args);
      return;
    }

    // 2. Clean up historical copies (keeping itself).
    await _cleanupStaleCopies(log);

    // 3. Wait for the main process to exit.
    log.i('Waiting for main process (pid=$waitPid) to exit');
    final exited = await _waitForProcessExit(waitPid, waitTimeout);
    if (!exited) {
      log.e('Timed out waiting for main process; skipping swap');
      await _relaunchApp(log, appDir, appExe);
      exit(3);
    }

    // 4. Mirror-replace.
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

    // 5. Delete the update temp directory.
    await _deleteWithRetry(Directory(p.join(appDir, UpdateSwapper.tempDirName)), log);

    // 6. Restart the main program.
    await _relaunchApp(log, appDir, appExe);
    log.i('Updater finished');
  }

  /// Parses `--key value` style arguments.
  static Map<String, String> _parseArgs(List<String> args) {
    final options = <String, String>{};
    for (var index = 0; index < args.length; index += 2) {
      if (index + 1 < args.length && args[index].startsWith('--')) {
        options[args[index]] = args[index + 1];
      }
    }
    return options;
  }

  /// Whether [path] is located under [dirPath].
  static bool _isInDir(String path, String dirPath) {
    final normalized = p.normalize(path).toLowerCase();
    final dir = p.normalize(dirPath).toLowerCase();
    return p.dirname(normalized) == dir;
  }

  /// Polls tasklist waiting for the process to exit; returns whether it
  /// exited before the timeout.
  static Future<bool> _waitForProcessExit(int targetPid, Duration timeout) async {
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
        // On tasklist failure, wait conservatively rather than swapping
        // early.
      }
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }
    return false;
  }

  /// Restarts the main program with the app directory as its working
  /// directory.
  static Future<void> _relaunchApp(_Logger log, String appDir, String appExe) async {
    final exePath = p.join(appDir, appExe);
    log.i('Relaunching $exePath');
    try {
      await Process.start(exePath, const [], workingDirectory: appDir);
    } catch (error) {
      log.e('Failed to relaunch $exePath: $error');
    }
  }

  /// Cleans up historical `foxy_updater_*.exe` copies under `%TEMP%`
  /// (keeping itself).
  static Future<void> _cleanupStaleCopies(_Logger log) async {
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

  /// Deletes a directory (3 retries, 300ms apart).
  static Future<void> _deleteWithRetry(Directory dir, _Logger log) async {
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
}

Future<void> main(List<String> args) => UpdaterMain.run(args);

/// Appends to the log.
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
      // A logging failure never affects the update flow.
    }
  }
}
