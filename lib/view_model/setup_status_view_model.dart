import 'dart:io';

import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

/// Single source of truth for directory config and first-setup completion,
/// shared by the settings-page items and the startup wizard.
///
/// - [clientDir]: client root directory (icon-extraction source; `client_dir`
///   in `config.yaml`)
/// - [dbcPath]: server DBC directory (DBC import/export source; `dbc_path`
///   in `config.yaml`)
/// - [iconsExtracted]: whether icons were fully extracted (the
///   `icons_extracted` marker written on successful extraction)
///
/// When a path is configured but its directory no longer exists (the user
/// moved/deleted it): signals keep the original path for UI prefill, the
/// `*Exists` signals mark validity, completion counts as incomplete, and
/// the wizard reappears on the next startup.
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

  /// Whether all three setup steps are complete (both directories
  /// configured and existing + icons extracted).
  bool get isSetupComplete =>
      isClientDirConfigured && isDbcPathConfigured && iconsExtracted.value;

  /// Loads directory config and the icon-extraction marker from config.
  ///
  /// When a path is configured but the directory is gone, the original
  /// path is kept (for UI prefill) while the corresponding `*Exists` flag
  /// is set false; completion counts as incomplete.
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

  /// Validates and persists the client directory; returns false on failure
  /// and writes [clientDirError].
  Future<bool> saveClientDir(String path) => _savePath(
        clientDir,
        clientDirExists,
        clientDirError,
        'client_dir',
        '客户端目录',
        path,
      );

  /// Validates and persists the server DBC directory; returns false on
  /// failure and writes [dbcPathError].
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
