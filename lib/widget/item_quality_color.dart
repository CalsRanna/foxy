import 'package:flutter/material.dart';

/// 物品品质的展示颜色。
///
/// 普通品质的客户端原色为白色。应用使用浅色背景，因此以黑色展示，避免
/// 文本不可见。
const kItemQualityColors = <int, Color>{
  0: Color(0xFF9D9D9D),
  1: Color(0xFF000000),
  2: Color(0xFF1EFF00),
  3: Color(0xFF0070DD),
  4: Color(0xFFA335EE),
  5: Color(0xFFFF8000),
  6: Color(0xFFE6CC80),
  7: Color(0xFF00CCFF),
};

Color getItemQualityColor(int quality) {
  return kItemQualityColors[quality] ?? Colors.black;
}
