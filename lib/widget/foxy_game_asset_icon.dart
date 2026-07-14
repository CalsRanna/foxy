import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:shadcn_ui/shadcn_ui.dart';

/// 游戏图标（物品/法术）统一渲染组件。
///
/// 输入是 DBC 里的原始图标路径（如 `Interface\Icons\INV_Misc_Foo`），
/// 统一规范化为文件系统路径并从 exe 同级的 `data/icon/` 目录加载。
///
/// 图标由 CMake install 步骤从 `asset/icon/` 拷贝到输出目录，不在 Flutter
/// asset bundle 中，以避免每次构建重建 150MB 的 asset bundle。
class FoxyGameAssetIcon extends StatelessWidget {
  /// DBC 原始图标路径（反斜杠、大小写不敏感，可含 `interface/icons` 前缀）。
  final String rawPath;

  /// 显示边长（正方形）。
  final double size;

  const FoxyGameAssetIcon({super.key, required this.rawPath, this.size = 40});

  /// 图标目录路径（懒加载，基于 exe 所在目录）。
  static final String _iconDir = () {
    return p.join(p.dirname(Platform.resolvedExecutable), 'data', 'icon');
  }();

  /// 将 DBC 原始路径规范化为文件系统路径。
  static String normalize(String rawPath) {
    var icon = rawPath
        .toLowerCase()
        .replaceAll('\\', '/')
        .replaceAll('interface/icons/', '');
    if (!icon.endsWith('.png')) icon = '$icon.png';
    return p.join(_iconDir, icon);
  }

  @override
  Widget build(BuildContext context) {
    final cache = (size * MediaQuery.devicePixelRatioOf(context)).round();
    return Image.file(
      File(normalize(rawPath)),
      height: size,
      width: size,
      fit: BoxFit.cover,
      cacheWidth: cache,
      cacheHeight: cache,
      errorBuilder: (context, error, stackTrace) => Icon(
        LucideIcons.image,
        size: size * 0.6,
        color: Theme.of(context).disabledColor,
      ),
    );
  }
}
