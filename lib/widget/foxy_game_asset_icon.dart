import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_cache.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_paths.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 游戏图标（物品/法术）统一渲染组件。
///
/// 输入是 DBC 里的原始图标路径（如 `Interface\Icons\INV_Misc_Foo`），
/// 规范化为小写纯文件名后从运行时当前目录的 `data/icon/<纯名>.blp` 加载。
///
/// 图标由用户在设置页从客户端 MPQ 提取（BLP 原始格式），应用不内置图标；
/// 未提取或客户端不存在的图标显示占位符。解码结果经 [GameIconCache] 缓存复用。
class FoxyGameAssetIcon extends StatefulWidget {
  /// DBC 原始图标路径（反斜杠、大小写不敏感，可含 `interface/icons` 前缀）。
  final String rawPath;

  /// 显示边长（正方形）。
  final double size;

  const FoxyGameAssetIcon({super.key, required this.rawPath, this.size = 40});

  @override
  State<FoxyGameAssetIcon> createState() => _FoxyGameAssetIconState();
}

class _FoxyGameAssetIconState extends State<FoxyGameAssetIcon> {
  ui.Image? _image;
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    final image = _image;
    if (image != null) {
      return RawImage(
        image: image,
        height: widget.size,
        width: widget.size,
        fit: BoxFit.cover,
      );
    }
    if (_loading) {
      return SizedBox.square(dimension: widget.size);
    }
    return Icon(
      LucideIcons.image,
      size: widget.size * 0.6,
      color: Theme.of(context).disabledColor,
    );
  }

  @override
  void didUpdateWidget(covariant FoxyGameAssetIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rawPath != widget.rawPath) _load();
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final path = GameIconPaths.blpPath(
      GameIconPaths.normalizeIconName(widget.rawPath),
    );
    final image = await GameIconCache.instance.load(path);
    if (!mounted) return;
    setState(() {
      _image = image;
      _loading = false;
    });
  }
}
