/// Update view model: a three-stage state machine of check → download →
/// restart.
///
/// Shared by the update dialog ([UpdateDialog]) and the startup auto-check
/// ([DashboardPage]).
/// Failure messages are mapped to Chinese copy via [foxyErrorMessage] and
/// written into [errorMessage].
library;

import 'dart:io';

import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/preferences/shared_preferences_util.dart';
import 'package:foxy/infrastructure/update/update_service.dart';
import 'package:foxy/infrastructure/update/update_swapper.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as p;
import 'package:signals/signals.dart';

class UpdateViewModel {
  UpdateViewModel({UpdateService? service, SharedPreferencesUtil? preferences})
      : _service = service ?? UpdateService(),
        _preferences = preferences ?? SharedPreferencesUtil.instance;

  /// Silent-check throttle: at most one check per 24h at startup.
  static const silentCheckInterval = Duration(hours: 24);

  final UpdateService _service;
  final SharedPreferencesUtil _preferences;

  UpdateCancelToken _cancelToken = UpdateCancelToken();

  /// Currently installed version (format `1.0.0+628`, loaded from
  /// package_info_plus).
  final currentVersion = signal<String?>(null);

  /// Whether an update check is in progress.
  final checking = signal<bool>(false);

  /// New version found by the check; null = none found.
  final availableUpdate = signal<UpdateManifestInfo?>(null);

  /// The last check confirmed "up to date".
  final upToDate = signal<bool>(false);

  /// Download progress 0..1; null = not downloading.
  final downloadProgress = signal<double?>(null);

  /// New version downloaded and extracted; a restart completes the update.
  final readyToRestart = signal<bool>(false);

  /// Failure message (Chinese copy already mapped via
  /// [foxyErrorMessage]).
  final errorMessage = signal<String?>(null);

  /// Extracted new-version payload root (passed to the helper program on
  /// restart).
  Directory? _payloadRoot;

  /// Loads the current version info (for the settings page and update
  /// dialog; loaded once).
  Future<void> prepare() async {
    if (currentVersion.value != null) return;
    try {
      final info = await PackageInfo.fromPlatform();
      currentVersion.value = '${info.version}+${info.buildNumber}';
    } catch (error) {
      LoggerUtil.instance.w('读取版本信息失败: $error');
    }
  }

  /// Runs the silent startup check: 24h throttle, failures only logged.
  /// Returns whether a new version was found.
  Future<bool> checkSilently() async {
    final last = await _preferences.getLastUpdateCheckAt();
    if (last != null &&
        DateTime.now().difference(last) < silentCheckInterval) {
      return false;
    }
    return _check(manual: false);
  }

  /// Manual check from the settings page: every outcome feeds back into
  /// the signals.
  Future<bool> checkManually() => _check(manual: true);

  Future<bool> _check({required bool manual}) async {
    if (checking.value) return false;
    checking.value = true;
    upToDate.value = false;
    readyToRestart.value = false;
    errorMessage.value = null;
    try {
      final result = await _service.checkForUpdates();
      await _preferences.setLastUpdateCheckAt(DateTime.now());
      switch (result) {
        case UpdateAvailable(:final update):
          availableUpdate.value = update;
          return true;
        case UpToDate():
          availableUpdate.value = null;
          upToDate.value = true;
          return false;
      }
    } catch (error) {
      availableUpdate.value = null;
      errorMessage.value = foxyErrorMessage(error);
      if (!manual) {
        LoggerUtil.instance.w('自动检查更新失败: $error');
      }
      return false;
    } finally {
      checking.value = false;
    }
  }

  /// Downloads and extracts the new version, writing progress to
  /// [downloadProgress]. Returns whether it succeeded.
  Future<bool> downloadAndPrepare() async {
    final update = availableUpdate.value;
    if (update == null || downloadProgress.value != null) return false;
    _cancelToken = UpdateCancelToken();
    readyToRestart.value = false;
    errorMessage.value = null;
    try {
      downloadProgress.value = 0;
      _payloadRoot = await _service.prepareUpdate(
        update,
        appDir: Directory.current,
        onProgress: (fraction) => downloadProgress.value = fraction,
        cancelToken: _cancelToken,
      );
      downloadProgress.value = null;
      readyToRestart.value = true;
      return true;
    } catch (error) {
      downloadProgress.value = null;
      errorMessage.value = foxyErrorMessage(error);
      return false;
    }
  }

  /// Cancels an in-progress download.
  void cancelDownload() => _cancelToken.cancel();

  /// Launches the update helper and exits the app; the helper completes
  /// the file swap and restarts.
  ///
  /// When the helper is missing or fails to launch, writes
  /// [errorMessage] and keeps the app running.
  Future<void> restartToApply() async {
    final appDir = Directory.current;
    final updaterExe = File(p.join(appDir.path, kUpdaterExeName));
    if (!await updaterExe.exists()) {
      errorMessage.value = '更新程序文件缺失，请重新下载完整版本';
      LoggerUtil.instance.e('更新辅助程序缺失: ${updaterExe.path}');
      return;
    }
    try {
      await Process.start(updaterExe.path, [
        '--app-dir',
        appDir.path,
        '--update-dir',
        _payloadRoot?.path ?? p.join(appDir.path, kUpdateTempDirName),
        '--wait-pid',
        '$pid',
        '--app-exe',
        kAppExeName,
      ]);
      exit(0);
    } catch (error) {
      errorMessage.value = '启动更新程序失败，请重试';
      LoggerUtil.instance.e('启动更新辅助程序失败: $error');
    }
  }
}
