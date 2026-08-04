import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_cache.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_paths.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Unified rendering component for game icons (items/spells).
///
/// Input is the raw icon path from the DBC (e.g.
/// `Interface\Icons\INV_Misc_Foo`), normalized to a lowercase bare file
/// name and loaded from `data/icon/<bare name>.blp` under the runtime
/// working directory.
///
/// Icons are extracted by the user from the client MPQs on the settings
/// page (raw BLP format); the app ships no icons. Missing or
/// client-nonexistent icons show a placeholder. Decoded results are cached
/// and reused via [GameIconCache].
class FoxyGameAssetIcon extends StatefulWidget {
  /// Raw DBC icon path (backslashes, case-insensitive; may carry an
  /// `interface/icons` prefix).
  final String rawPath;

  /// Display edge length (square).
  final double size;

  const FoxyGameAssetIcon({super.key, required this.rawPath, this.size = 40});

  @override
  State<FoxyGameAssetIcon> createState() => _FoxyGameAssetIconState();
}

class _FoxyGameAssetIconState extends State<FoxyGameAssetIcon> {
  ui.Image? _image;
  bool _loading = true;

  /// Normalized path of this request; compared against the current widget
  /// when loading finishes, so a slow old-path load never overwrites the
  /// new-path icon.
  String? _requestedPath;

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
      size: widget.size,
      color: Theme.of(context).disabledColor,
    );
  }

  @override
  void didUpdateWidget(covariant FoxyGameAssetIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rawPath != widget.rawPath) {
      // On icon change, reset state immediately: clear the old image, go
      // back to loading, then start the new load.
      _image = null;
      _loading = true;
      _load();
    }
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
    _requestedPath = path;
    ui.Image? image;
    try {
      image = await GameIconCache.instance.load(path);
    } catch (_) {
      // The cache layer should return null on decode failure; here IO/decode
      // exceptions are caught as a fallback and treated as missing.
      image = null;
    }
    if (!mounted || path != _requestedPath) return;
    setState(() {
      _image = image;
      _loading = false;
    });
  }
}
