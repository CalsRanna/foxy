import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foxy/di.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/update/update_swapper.dart';
import 'package:foxy/infrastructure/window/window_initializer.dart';
import 'package:foxy/page/foxy_app/foxy_app.dart';
import 'package:path/path.dart' as p;
import 'package:signals/signals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowInitializer.ensureInitialized();
  DI.ensureInitialized();
  SignalsObserver.instance = null;
  _cleanupStaleUpdateTemp();
  runApp(FoxyApp());
}

/// Cleans up a leftover `.update_tmp/` directory from an interrupted
/// update (does not block startup).
///
/// Update flow: download and extract into `.update_tmp/` → after restart
/// `foxy_updater.exe` swaps and deletes it; if the app is force-killed
/// before the swap, this cleanup covers the leftovers and the next update
/// check rediscovers the new version.
void _cleanupStaleUpdateTemp() {
  final dir = Directory(p.join(Directory.current.path, kUpdateTempDirName));
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
