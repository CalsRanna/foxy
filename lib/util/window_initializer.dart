import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foxy/util/shared_preferences_util.dart';
import 'package:window_manager/window_manager.dart';

class WindowInitializer with WindowListener {
  static const _defaultWidth = 1000.0;
  static const _defaultHeight = 750.0;

  static WindowInitializer? _instance;

  WindowInitializer._();

  @override
  void onWindowResize() async {
    final size = await windowManager.getSize();
    await _saveWindowSize(size);
  }

  Future<Size> _getSavedWindowSize() async {
    final instance = SharedPreferencesUtil.instance;
    final width = await instance.getWindowWidth();
    final height = await instance.getWindowHeight();
    return Size(width, height);
  }

  Future<void> _initialize() async {
    await windowManager.ensureInitialized();

    final savedSize = await _getSavedWindowSize();
    final options = WindowOptions(
      backgroundColor: Colors.transparent,
      center: true,
      minimumSize: const Size(_defaultWidth, _defaultHeight),
      size: savedSize,
      titleBarStyle: TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );

    windowManager.waitUntilReadyToShow(options, () async {
      await windowManager.show();
      await windowManager.focus();
    });

    windowManager.addListener(this);
  }

  Future<void> _saveWindowSize(Size size) async {
    final instance = SharedPreferencesUtil.instance;
    await instance.setWindowWidth(size.width);
    await instance.setWindowHeight(size.height);
  }

  static Future<void> ensureInitialized() async {
    if (kIsWeb) return;
    if (Platform.isAndroid || Platform.isFuchsia || Platform.isIOS) return;

    _instance = WindowInitializer._();
    await _instance!._initialize();
  }

  static Future<void> opaque() async {
    if (kIsWeb) return;
    if (Platform.isAndroid || Platform.isFuchsia || Platform.isIOS) return;
    await windowManager.setOpacity(1);
  }

  static Future<void> resize(Size size) async {
    if (kIsWeb) return;
    if (Platform.isAndroid || Platform.isFuchsia || Platform.isIOS) return;
    await windowManager.setOpacity(0);
    await Future.wait([windowManager.setSize(size), windowManager.center()]);
  }
}
