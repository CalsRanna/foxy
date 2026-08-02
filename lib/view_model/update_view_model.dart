/// 更新视图模型:检查 → 下载 → 重启 三阶段状态机。
///
/// 供更新对话框([UpdateDialog])与启动自动检查([DashboardPage])共用。
/// 失败信息经 [foxyErrorMessage] 映射为中文文案写入 [errorMessage]。
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

  /// 静默检查节流间隔:启动时 24h 内最多检查一次。
  static const silentCheckInterval = Duration(hours: 24);

  final UpdateService _service;
  final SharedPreferencesUtil _preferences;

  UpdateCancelToken _cancelToken = UpdateCancelToken();

  /// 当前安装版本(格式 `1.0.0+628`,加载自 package_info_plus)。
  final currentVersion = signal<String?>(null);

  /// 是否正在检查更新。
  final checking = signal<bool>(false);

  /// 检查发现的新版本;null = 未发现。
  final availableUpdate = signal<UpdateManifestInfo?>(null);

  /// 最近一次检查确认「已是最新」。
  final upToDate = signal<bool>(false);

  /// 下载进度 0..1;null = 未在下载。
  final downloadProgress = signal<double?>(null);

  /// 新版本已下载并解压,等待重启完成更新。
  final readyToRestart = signal<bool>(false);

  /// 失败信息(已经 [foxyErrorMessage] 映射的中文文案)。
  final errorMessage = signal<String?>(null);

  /// 已解压的新版本 payload 根目录(重启时传给辅助程序)。
  Directory? _payloadRoot;

  /// 加载当前版本信息(设置页与更新对话框展示用,只加载一次)。
  Future<void> prepare() async {
    if (currentVersion.value != null) return;
    try {
      final info = await PackageInfo.fromPlatform();
      currentVersion.value = '${info.version}+${info.buildNumber}';
    } catch (error) {
      LoggerUtil.instance.w('读取版本信息失败: $error');
    }
  }

  /// 启动静默检查:24h 节流,失败仅记日志。返回是否发现新版本。
  Future<bool> checkSilently() async {
    final last = await _preferences.getLastUpdateCheckAt();
    if (last != null &&
        DateTime.now().difference(last) < silentCheckInterval) {
      return false;
    }
    return _check(manual: false);
  }

  /// 设置页手动检查:任何结果都反馈到信号。
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

  /// 下载并解压新版本,进度写 [downloadProgress]。返回是否成功。
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

  /// 取消进行中的下载。
  void cancelDownload() => _cancelToken.cancel();

  /// 启动更新辅助程序并退出应用,由辅助程序完成文件交换后重启。
  ///
  /// 辅助程序缺失或启动失败时写入 [errorMessage] 并保持应用运行。
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
