import 'package:flutter/material.dart';

/// Display colors for item quality.
///
/// The client's native color for common quality is white. The app uses a
/// light background, so it renders black to keep the text visible.
abstract final class ItemQualityColor {
  static const colors = <int, Color>{
    0: Color(0xFF9D9D9D),
    1: Color(0xFF000000),
    2: Color(0xFF1EFF00),
    3: Color(0xFF0070DD),
    4: Color(0xFFA335EE),
    5: Color(0xFFFF8000),
    6: Color(0xFFE6CC80),
    7: Color(0xFF00CCFF),
  };

  static Color of(int quality) => colors[quality] ?? Colors.black;
}
