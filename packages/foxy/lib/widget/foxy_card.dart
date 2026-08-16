import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Dashboard card: title + content in a [ShadCard] container.
///
/// Implemented on top of [ShadCard] so dashboard cards share the same
/// radius, borders and color tokens as every other card in the app
/// (previously a hand-rolled Material container with its own shadow and a
/// different corner radius).
///
/// The [child] is passed through unpadded; call sites add their own
/// padding (dashboard components carry their own `Padding`).
class FoxyCard extends StatelessWidget {
  final Widget? title;
  final Widget child;

  const FoxyCard({super.key, this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: DefaultTextStyle.merge(
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                child: title!,
              ),
            ),
            const _Divider(),
          ],
          child,
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    return Divider(color: outline.withValues(alpha: 0.2), height: 1);
  }
}
