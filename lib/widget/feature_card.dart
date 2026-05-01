import 'package:flutter/material.dart';
import 'package:foxy/entity/feature_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

const _kFeatureIconMap = <String, IconData>{
  'pawPrint': LucideIcons.pawPrint,
  'swords': LucideIcons.swords,
  'badgeQuestionMark': LucideIcons.badgeQuestionMark,
  'mapPin': LucideIcons.mapPin,
  'messageCircle': LucideIcons.messageCircle,
  'code': LucideIcons.code,
  'shell': LucideIcons.shell,
  'list': LucideIcons.list,
  'bookOpen': LucideIcons.bookOpen,
  'listFilter': LucideIcons.listFilter,
  'userPlus': LucideIcons.userPlus,
  'map': LucideIcons.map,
  'laugh': LucideIcons.laugh,
  'trophy': LucideIcons.trophy,
  'arrowUpDown': LucideIcons.arrowUpDown,
  'trendingUp': LucideIcons.trendingUp,
  'info': LucideIcons.info,
  'coins': LucideIcons.coins,
  'wand': LucideIcons.wand,
  'gem': LucideIcons.gem,
  'triangle': LucideIcons.triangle,
  'award': LucideIcons.award,
  'banknote': LucideIcons.banknote,
  'layers': LucideIcons.layers,
  'ruler': LucideIcons.ruler,
  'sparkles': LucideIcons.sparkles,
};

class FeatureCard extends StatefulWidget {
  final FeatureEntity feature;
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
        _kFeatureIconMap[widget.feature.icon] ?? LucideIcons.circleAlert;
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
    final descriptionStyle = TextStyle(
      fontSize: 13,
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
    );
    final lineHeight = _measureLineHeight(descriptionStyle);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        const SizedBox(height: 16),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxLines = (constraints.maxHeight / lineHeight)
                  .floor()
                  .clamp(1, 20);
              return Text(
                widget.feature.description,
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
                style: descriptionStyle,
              );
            },
          ),
        ),
      ],
    );
  }

  /// The line height is determined by font metrics (ascent + descent + leading),
  /// not by the text content. A single space suffices to measure it.
  double _measureLineHeight(TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: ' ', style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    return painter.preferredLineHeight;
  }
}
