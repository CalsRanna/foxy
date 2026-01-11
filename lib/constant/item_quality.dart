import 'package:flutter/material.dart';

/// 物品品质枚举
enum ItemQuality {
  poor(0, 'Poor', '粗糙'),
  common(1, 'Common', '普通'),
  uncommon(2, 'Uncommon', '优秀'),
  rare(3, 'Rare', '精良'),
  epic(4, 'Epic', '史诗'),
  legendary(5, 'Legendary', '传说'),
  artifact(6, 'Artifact', '神器'),
  heirloom(7, 'Heirloom', '传家宝');

  final int value;
  final String name;
  final String zhName;

  const ItemQuality(this.value, this.name, this.zhName);

  static ItemQuality? fromValue(int value) {
    return ItemQuality.values.cast<ItemQuality?>().firstWhere(
      (e) => e?.value == value,
      orElse: () => null,
    );
  }
}

/// 物品品质颜色映射
///
/// 颜色值来源于魔兽世界官方的物品品质颜色定义。
///
/// 注意：普通品质(Common)的原始颜色是白色(#FFFFFF)，
/// 但由于应用程序使用白色背景，白色文字在白色背景上不可见，
/// 因此这里将普通品质的颜色改为黑色(#000000)以保证可读性。
const kItemQualityColors = <int, Color>{
  0: Color(0xFF9D9D9D), // Poor 粗糙 (灰色)
  1: Color(0xFF000000), // Common 普通 (黑色 - 原为白色，因白色背景改用黑色)
  2: Color(0xFF1EFF00), // Uncommon 优秀 (绿色)
  3: Color(0xFF0070DD), // Rare 精良 (蓝色)
  4: Color(0xFFA335EE), // Epic 史诗 (紫色)
  5: Color(0xFFFF8000), // Legendary 传说 (橙色)
  6: Color(0xFFE6CC80), // Artifact 神器 (浅金色)
  7: Color(0xFF00CCFF), // Heirloom 传家宝 (浅蓝色)
};

/// 根据品质值获取对应颜色
///
/// [quality] 物品品质值 (0-7)
/// 返回对应的颜色，如果品质值无效则返回黑色（用于白色背景）
Color getItemQualityColor(int quality) {
  return kItemQualityColors[quality] ?? Colors.black;
}
