import 'package:flutter/material.dart';

/// 游戏图标（物品/法术）统一渲染组件。
///
/// 输入是 DBC 里的原始图标路径（如 `Interface\Icons\INV_Misc_Foo`），
/// 统一规范化为项目内资源路径并加载。相比在列表单元格里直接
/// `Image.asset`，这里补齐了两点关键防护/优化：
///
/// - **[errorBuilder]**：AzerothCore 的图标资源常不齐全，缺图标时
///   `Image.asset` 会在 paint 阶段抛异常、刷日志并掉帧。这里回退到占位图标。
/// - **[cacheWidth]**：按显示尺寸解码，避免为 40×40 的槽位解码整张原图。
///
/// 路径规范化逻辑此前重复在物品/法术列表页，且每次单元格重建都重跑
/// 两次 `replaceAll`。集中到此处一份。
class GameAssetIcon extends StatelessWidget {
  /// DBC 原始图标路径（反斜杠、大小写不敏感，可含 `interface/icons` 前缀）。
  final String rawPath;

  /// 显示边长（正方形）。
  final double size;

  const GameAssetIcon({super.key, required this.rawPath, this.size = 40});

  /// 将 DBC 原始路径规范化为 `asset/icon/xxx.png`。
  static String normalize(String rawPath) {
    var icon = rawPath
        .toLowerCase()
        .replaceAll('\\', '/')
        .replaceAll('interface/icons', 'asset/icon');
    if (!icon.startsWith('asset/icon/')) {
      icon = 'asset/icon/$icon';
    }
    return '$icon.png';
  }

  @override
  Widget build(BuildContext context) {
    // 按设备像素比解码到目标尺寸，避免全尺寸解码。
    final cache = (size * MediaQuery.devicePixelRatioOf(context)).round();
    return Image.asset(
      normalize(rawPath),
      height: size,
      width: size,
      fit: BoxFit.cover,
      cacheWidth: cache,
      cacheHeight: cache,
      // 缺失/损坏的图标不再抛异常掉帧，回退到占位图标。
      errorBuilder: (context, error, stackTrace) => Icon(
        Icons.image_not_supported_outlined,
        size: size * 0.6,
        color: Theme.of(context).disabledColor,
      ),
    );
  }
}
