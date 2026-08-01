import 'dart:io';

import 'package:path/path.dart' as p;

/// 游戏图标缓存目录与名称规范化的集中定义。
class GameIconPaths {
  /// 图标缓存目录（运行时当前目录下的 `data/icon/`，与 config.yaml 位置一致）。
  static String get iconDir => p.join(Directory.current.path, 'data', 'icon');

  GameIconPaths._();

  /// 纯文件名 → 提取产物路径。
  static String blpPath(String name) => p.join(iconDir, '$name.blp');

  /// 将 DBC 原始图标路径规范化为小写纯文件名（去目录、去扩展名）。
  ///
  /// 例如 `Interface\Icons\INV_Misc_Foo`、`inv_shoulder_94.tga` 都归一到
  /// 纯名（`inv_misc_foo` / `inv_shoulder_94`），与提取产物扁平布局对应。
  static String normalizeIconName(String rawPath) {
    var name = rawPath.toLowerCase().replaceAll('\\', '/');
    final slash = name.lastIndexOf('/');
    if (slash >= 0) name = name.substring(slash + 1);
    final dot = name.lastIndexOf('.');
    if (dot > 0) name = name.substring(0, dot);
    return name;
  }
}
