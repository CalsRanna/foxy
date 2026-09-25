import 'dart:io';

import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_extractor.dart';
import 'package:foxy/infrastructure/server/server_dir_resolver.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

/// Single source of truth for directory config and first-setup completion,
/// shared by the settings-page items and the startup wizard.
///
/// - [clientDir]: client root directory (icon-extraction source; `client_dir`
///   in `config.yaml`)
/// - [mpqDir]: MPQ archive directory auto-detected under the client
///   (`Data/<locale>/`; `mpq_dir` in `config.yaml`) — written on save, used
///   by icon extraction and future MPQ patch generation
/// - [serverDir]: server root directory (`server_dir` in `config.yaml`)
/// - [dbcPath]: DBC file directory auto-detected inside the server root
///   (DBC import/export source; `dbc_dir` in `config.yaml`)
/// - [iconsExtracted]: whether icons were fully extracted (the
///   `icons_extracted` marker written on successful extraction)
/// - [iconsSkipped]: the user chose to continue without icons
///   (`icons_skipped`); this also counts as complete, so a client whose
///   archives cannot be read never keeps reopening the wizard
///
/// When a path is configured but its directory no longer exists (the user
/// moved/deleted it): signals keep the original path for UI prefill, the
/// `*Exists` signals mark validity, completion counts as incomplete, and
/// the wizard reappears on the next startup.
class SetupStatusViewModel {
  final ConfigUtil _configUtil;

  /// Server-root → DBC directory detector (tests inject a fake).
  final Future<String?> Function(String serverRoot) _findDbcDir;

  /// Client-root → MPQ archive directory detector (tests inject a fake).
  final String? Function(String clientRoot) _findMpqDir;

  final clientDir = signal<String?>(null);
  final dbcPath = signal<String?>(null);
  final serverDir = signal<String?>(null);
  final mpqDir = signal<String?>(null);
  final clientDirExists = signal<bool>(false);
  final dbcPathExists = signal<bool>(false);
  final serverDirExists = signal<bool>(false);
  final iconsExtracted = signal<bool>(false);
  final iconsSkipped = signal<bool>(false);

  final clientDirError = signal<String?>(null);
  final serverDirError = signal<String?>(null);

  SetupStatusViewModel({
    ConfigUtil? configUtil,
    Future<String?> Function(String serverRoot)? findDbcDir,
    String? Function(String clientRoot)? findMpqDir,
  }) : _configUtil = configUtil ?? GetIt.instance.get<ConfigUtil>(),
       _findDbcDir = findDbcDir ?? ServerDirResolver.findDbcDir,
       _findMpqDir = findMpqDir ?? GameIconExtractor.findLocaleDataDir;

  bool get isClientDirConfigured =>
      clientDir.value != null && clientDirExists.value;

  bool get isDbcPathConfigured => dbcPath.value != null && dbcPathExists.value;

  bool get isServerDirConfigured =>
      serverDir.value != null && serverDirExists.value;

  /// Whether first setup is complete: the server directory is configured
  /// and existing, and icons were extracted or deliberately skipped.
  ///
  /// Skipping also covers having no client directory at all (the client is
  /// only needed for icons and MPQ patches), so a user whose client cannot
  /// be validated is not kept out of the app.
  bool get isSetupComplete =>
      isServerDirConfigured &&
      (iconsSkipped.value || (isClientDirConfigured && iconsExtracted.value));

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

    final server = config['server_dir']?.toString().trim();
    serverDir.value = (server == null || server.isEmpty) ? null : server;
    serverDirExists.value =
        serverDir.value == null || await Directory(serverDir.value!).exists();

    final dbc = config['dbc_dir']?.toString().trim();
    dbcPath.value = (dbc == null || dbc.isEmpty) ? null : dbc;
    dbcPathExists.value =
        dbcPath.value == null || await Directory(dbcPath.value!).exists();

    final mpq = config['mpq_dir']?.toString().trim();
    mpqDir.value = (mpq == null || mpq.isEmpty) ? null : mpq;

    iconsExtracted.value = config['icons_extracted'] == true;
    iconsSkipped.value = config['icons_skipped'] == true;
  }

  /// Validates and persists the client directory, auto-detecting the MPQ
  /// archive directory under it (`mpq_dir`); returns false and writes
  /// [clientDirError] when the directory is invalid or holds no MPQ archive
  /// directory at all (mirrors [saveServerDir]'s DBC check: a client
  /// directory without archives can only make icon extraction fail).
  Future<bool> saveClientDir(String path) async {
    if (!await _validatePath(clientDirError, '客户端目录', path)) return false;
    final mpq = _findMpqDir(path.trim());
    if (mpq == null) {
      clientDirError.value =
          '在客户端目录中未找到 MPQ 归档(如 Data/zhCN),请确认选择的是客户端根目录';
      return false;
    }
    await _configUtil.update({'client_dir': path.trim(), 'mpq_dir': mpq});
    clientDir.value = path.trim();
    clientDirExists.value = true;
    mpqDir.value = mpq;
    return true;
  }

  /// Marks the icon-extraction step as skipped so first setup counts as
  /// complete: icons are optional (list pages fall back to placeholders and
  /// the settings page can extract them later), and a client whose archives
  /// cannot be read must not keep the wizard reopening forever.
  Future<void> skipIconExtraction() async {
    await _configUtil.update({'icons_skipped': true});
    iconsSkipped.value = true;
  }

  /// Validates and persists the server root directory, auto-detecting the
  /// DBC file directory inside it and persisting both `server_dir` and
  /// `dbc_dir`; returns false on failure and writes [serverDirError].
  Future<bool> saveServerDir(String path) async {
    if (!await _validatePath(serverDirError, '服务端目录', path)) return false;
    final dbc = await _findDbcDir(path.trim());
    if (dbc == null) {
      serverDirError.value = '在服务端目录中未找到 DBC 文件(如 data/dbc),请确认 DBC 数据已放置';
      return false;
    }
    await _configUtil.update({'server_dir': path.trim(), 'dbc_dir': dbc});
    serverDir.value = path.trim();
    serverDirExists.value = true;
    dbcPath.value = dbc;
    dbcPathExists.value = true;
    return true;
  }

  /// Shared directory validation: non-empty and existing, writing the
  /// error through [errorSignal] on failure.
  Future<bool> _validatePath(
    Signal<String?> errorSignal,
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
    return true;
  }
}
