import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

class WindowInitializer with WindowListener {
  static const _keyWidth = 'window_width';
  static const _keyHeight = 'window_height';
  static const _defaultWidth = 1000.0;
  static const _defaultHeight = 750.0;

  static WindowInitializer? _instance;
  late SharedPreferences _prefs;

  WindowInitializer._();

  static Future<void> ensureInitialized() async {
    if (kIsWeb) return;
    if (Platform.isAndroid || Platform.isFuchsia || Platform.isIOS) return;

    _instance = WindowInitializer._();
    await _instance!._initialize();
  }

  Future<void> _initialize() async {
    _prefs = await SharedPreferences.getInstance();
    await windowManager.ensureInitialized();

    final savedSize = _getSavedWindowSize();
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

  Size _getSavedWindowSize() {
    final width = _prefs.getDouble(_keyWidth) ?? _defaultWidth;
    final height = _prefs.getDouble(_keyHeight) ?? _defaultHeight;
    return Size(width, height);
  }

  Future<void> _saveWindowSize(Size size) async {
    await _prefs.setDouble(_keyWidth, size.width);
    await _prefs.setDouble(_keyHeight, size.height);
  }

  @override
  void onWindowResize() async {
    final size = await windowManager.getSize();
    await _saveWindowSize(size);
  }

  static Future<void> resize(Size size) async {
    if (kIsWeb) return;
    if (Platform.isAndroid || Platform.isFuchsia || Platform.isIOS) return;
    await windowManager.setOpacity(0);
    await Future.wait([windowManager.setSize(size), windowManager.center()]);
  }

  static Future<void> opaque() async {
    if (kIsWeb) return;
    if (Platform.isAndroid || Platform.isFuchsia || Platform.isIOS) return;
    await windowManager.setOpacity(1);
  }
}
