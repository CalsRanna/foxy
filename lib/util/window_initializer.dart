import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowInitializer {
  static Future<void> ensureInitialized() async {
    if (kIsWeb) return;
    if (Platform.isAndroid || Platform.isFuchsia || Platform.isIOS) return;
    await windowManager.ensureInitialized();
    const options = WindowOptions(
      backgroundColor: Colors.transparent,
      center: true,
      minimumSize: Size(1200, 900),
      size: Size(400, 300),
      titleBarStyle: TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );
    windowManager.waitUntilReadyToShow(options, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  static Future<void> resize(Size size) async {
    if (kIsWeb) return;
    if (Platform.isAndroid || Platform.isFuchsia || Platform.isIOS) return;
    await windowManager.setOpacity(0);
    await Future.wait([
      windowManager.setSize(size),
      windowManager.center(),
    ]);
  }

  static Future<void> opaque() async {
    if (kIsWeb) return;
    if (Platform.isAndroid || Platform.isFuchsia || Platform.isIOS) return;
    await windowManager.setOpacity(1);
  }
}
