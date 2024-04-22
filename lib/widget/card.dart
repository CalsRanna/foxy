import 'package:flutter/material.dart';

class FoxyCard extends StatefulWidget {
  const FoxyCard({super.key, this.title, this.child});

  final Widget? title;
  final Widget? child;

  @override
  State<FoxyCard> createState() => _FoxyCardState();
}

class _FoxyCardState extends State<FoxyCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    final surface = colorScheme.surface;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: outline.withOpacity(0.1),
            spreadRadius: 8,
          )
        ],
        color: surface,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) ...[
            DefaultTextStyle.merge(
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              child: widget.title!,
            ),
            const SizedBox(height: 16),
          ],
          widget.child ?? const SizedBox(),
        ],
      ),
    );
  }
}
