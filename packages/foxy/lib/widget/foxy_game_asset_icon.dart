import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/game_asset/blp_icon_provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Unified rendering component for game icons (items/spells).
///
/// Input is the raw icon path from the DBC (e.g.
/// `Interface\Icons\INV_Misc_Foo`), loaded via [BlpIconProvider] through
/// the Flutter [ImageCache]: the provider normalizes the name, resolves
/// `data/icon/<bare name>.blp` under the runtime working directory, and
/// decodes the BLP.
///
/// Icons are extracted by the user from the client MPQs on the settings
/// page (raw BLP format); the app ships no icons. Missing or
/// client-nonexistent icons show a placeholder. Caching, deduplication and
/// texture lifetime are managed by the framework's [ImageCache]; a
/// `loading` frame shows a blank square.
class FoxyGameAssetIcon extends StatelessWidget {
  /// Raw DBC icon path (backslashes, case-insensitive; may carry an
  /// `interface/icons` prefix).
  final String rawPath;

  /// Display edge length (square).
  final double size;

  const FoxyGameAssetIcon({super.key, required this.rawPath, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: BlpIconProvider(rawPath: rawPath),
      width: size,
      height: size,
      fit: BoxFit.cover,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        return frame == null ? SizedBox.square(dimension: size) : child;
      },
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          LucideIcons.image,
          size: size,
          color: Theme.of(context).disabledColor,
        );
      },
    );
  }
}
