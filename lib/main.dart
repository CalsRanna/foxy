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

/// 清理上次更新中断遗留的 `.update_tmp/` 目录(不阻塞启动)。
///
/// 更新流程:下载解压到 `.update_tmp/` → 重启后由 `foxy_updater.exe` 完成
/// 交换并删除;若交换前应用被强杀,这里兜底清理,下次更新检查会重新发现
/// 新版本。
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
