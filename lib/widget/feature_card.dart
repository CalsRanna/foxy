import 'package:flutter/material.dart';
import 'package:foxy/constant/feature_icons.dart';
import 'package:foxy/model/feature.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FeatureCard extends StatefulWidget {
  final Feature feature;
  final bool seamless;
  final Border? border;
  final VoidCallback onTap;
  final void Function(Offset position)? onSecondaryTap;

  const FeatureCard({
    super.key,
    required this.feature,
    this.seamless = false,
    this.border,
    required this.onTap,
    this.onSecondaryTap,
  });

  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard> {
  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;

    final child = GestureDetector(
      onTap: widget.onTap,
      onSecondaryTapDown: widget.onSecondaryTap != null
          ? (details) => widget.onSecondaryTap!(details.globalPosition)
          : null,
      child: widget.seamless
          ? Container(
              decoration: BoxDecoration(border: widget.border, color: surface),
              padding: const EdgeInsets.all(16),
              child: _buildContent(),
            )
          : ShadCard(padding: const EdgeInsets.all(16), child: _buildContent()),
    );

    return MouseRegion(cursor: SystemMouseCursors.click, child: child);
  }

  Widget _buildContent() {
    final iconData =
        featureIconMap[widget.feature.icon] ?? LucideIcons.circleAlert;
    final tag = Text(
      widget.feature.category.toUpperCase(),
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
    );
    final titleColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(widget.feature.name), tag],
    );
    final title = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(iconData),
        const SizedBox(width: 16),
        Expanded(child: titleColumn),
      ],
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        const SizedBox(height: 16),
        SizedBox(
          height: 72,
          child: Text(
            widget.feature.description,
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
      ],
    );
  }
}
