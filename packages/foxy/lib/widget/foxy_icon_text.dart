import 'package:flutter/material.dart';
import 'package:foxy/widget/foxy_game_asset_icon.dart';

/// Single-line "game icon + name" row, used for name columns in list pages
/// and entity pickers.
///
/// [iconPath] is the raw DBC icon path passed through to [FoxyGameAssetIcon];
/// [nameColor] is optional (e.g. item quality color) and defaults to the
/// theme's text color.
class FoxyIconText extends StatelessWidget {
  const FoxyIconText({
    super.key,
    required this.iconPath,
    required this.name,
    this.nameColor,
    this.iconSize = 40,
    this.iconRadius = 6,
  });

  /// Raw DBC icon path (backslashes, case-insensitive).
  final String iconPath;

  /// Display name text, single line with ellipsis overflow.
  final String name;

  /// Optional name color, e.g. item quality color.
  final Color? nameColor;

  /// Icon edge length (square), defaults to [FoxyGameAssetIcon]'s 40.
  final double iconSize;

  /// Icon corner radius.
  final double iconRadius;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(iconRadius),
          child: FoxyGameAssetIcon(rawPath: iconPath, size: iconSize),
        ),
        Expanded(
          child: Text(
            name,
            style: nameColor == null ? null : TextStyle(color: nameColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
