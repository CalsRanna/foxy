import 'package:flutter/material.dart';

class FoxyCard extends StatelessWidget {
  final Widget? title;
  final Widget child;

  const FoxyCard({super.key, this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    final surface = colorScheme.surface;
    final boxShadow = BoxShadow(
      blurRadius: 8,
      color: outline.withValues(alpha: 0.1),
      spreadRadius: 8,
    );
    final boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      boxShadow: [boxShadow],
      color: surface,
    );
    final title = _buildTitle(context);
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [...title, child],
    );
    return Container(decoration: boxDecoration, child: column);
  }

  List<Widget> _buildTitle(BuildContext context) {
    if (title == null) return [];
    const textStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    final titleWidget = DefaultTextStyle.merge(
      style: textStyle,
      child: title!,
    );
    final padding = Padding(padding: EdgeInsets.all(16), child: titleWidget);
    return [padding, const _Divider()];
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
