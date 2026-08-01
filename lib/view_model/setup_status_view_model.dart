import 'dart:io';

import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

/// 目录配置与首次设置完成度的单一来源，供设置页配置项与启动引导共用。
///
/// - [clientDir]：客户端根目录（图标提取来源，`config.yaml` 的 `client_dir`）
/// - [dbcPath]：服务端 DBC 目录（DBC 导入/导出来源，`config.yaml` 的 `dbc_path`）
/// - [iconsExtracted]：图标是否已完整提取（提取任务成功时写入的 `icons_extracted` 标记）
///
/// 配置了路径但目录已不存在的场景（用户移动/删除了目录）：信号仍保留原始
/// 路径用于界面预填，`*Exists` 信号标记有效性，完成度判定按未完成处理，
/// 下次启动会重新弹出引导。
class SetupStatusViewModel {
  final ConfigUtil _configUtil;

  final clientDir = signal<String?>(null);
  final dbcPath = signal<String?>(null);
  final clientDirExists = signal<bool>(false);
  final dbcPathExists = signal<bool>(false);
  final iconsExtracted = signal<bool>(false);

  final clientDirError = signal<String?>(null);
  final dbcPathError = signal<String?>(null);

  SetupStatusViewModel({ConfigUtil? configUtil})
      : _configUtil = configUtil ?? GetIt.instance.get<ConfigUtil>();

  bool get isClientDirConfigured =>
      clientDir.value != null && clientDirExists.value;

  bool get isDbcPathConfigured => dbcPath.value != null && dbcPathExists.value;

  /// 三步设置是否全部完成（两个目录已配置且存在 + 图标已提取）。
  bool get isSetupComplete =>
      isClientDirConfigured && isDbcPathConfigured && iconsExtracted.value;

  /// 从 config 加载目录配置与图标提取标记。
  ///
  /// 配置了路径但目录已不存在时保留原始路径（用于界面预填），
  /// 但对应的 `*Exists` 标记置 false，完成度按未完成处理。
  Future<void> prepare() async {
    final config = await _configUtil.load();

    final client = config['client_dir']?.toString().trim();
    clientDir.value = (client == null || client.isEmpty) ? null : client;
    clientDirExists.value =
        clientDir.value == null || await Directory(clientDir.value!).exists();

    final dbc = config['dbc_path']?.toString().trim();
    dbcPath.value = (dbc == null || dbc.isEmpty) ? null : dbc;
    dbcPathExists.value =
        dbcPath.value == null || await Directory(dbcPath.value!).exists();

    iconsExtracted.value = config['icons_extracted'] == true;
  }

  /// 校验并持久化客户端目录；失败返回 false 并写入 [clientDirError]。
  Future<bool> saveClientDir(String path) => _savePath(
        clientDir,
        clientDirExists,
        clientDirError,
        'client_dir',
        '客户端目录',
        path,
      );

  /// 校验并持久化服务端 DBC 目录；失败返回 false 并写入 [dbcPathError]。
  Future<bool> saveDbcPath(String path) => _savePath(
        dbcPath,
        dbcPathExists,
        dbcPathError,
        'dbc_path',
        '服务端 DBC 目录',
        path,
      );

  Future<bool> _savePath(
    Signal<String?> target,
    Signal<bool> existsSignal,
    Signal<String?> errorSignal,
    String key,
    String label,
    String path,
  ) async {
    final trimmed = path.trim();
    if (trimmed.isEmpty) {
      errorSignal.value = '请选择$label。';
      return false;
    }
    if (!await Directory(trimmed).exists()) {
      errorSignal.value = '目录不存在：$trimmed';
      return false;
    }
    errorSignal.value = null;
    await _configUtil.update({key: trimmed});
    target.value = trimmed;
    existsSignal.value = true;
    return true;
  }
}
