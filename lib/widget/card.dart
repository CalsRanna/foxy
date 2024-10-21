import 'package:flutter/material.dart';

class ArcaneCard extends StatefulWidget {
  final Widget? title;
  final Widget child;

  const ArcaneCard({super.key, this.title, required this.child});

  @override
  State<ArcaneCard> createState() => _ArcaneCardState();
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    return Divider(color: outline.withOpacity(0.2), height: 1);
  }
}

class _ArcaneCardState extends State<ArcaneCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    final surface = colorScheme.surface;
    final boxShadow = BoxShadow(
      blurRadius: 8,
      color: outline.withOpacity(0.1),
      spreadRadius: 8,
    );
    final boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      boxShadow: [boxShadow],
      color: surface,
    );
    final title = _buildTitle();
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [...title, widget.child],
    );
    return Container(decoration: boxDecoration, child: column);
  }

  List<Widget> _buildTitle() {
    if (widget.title == null) return [];
    const textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    final title = DefaultTextStyle.merge(
      style: textStyle,
      child: widget.title!,
    );
    final padding = Padding(padding: EdgeInsets.all(16), child: title);
    return [padding, const _Divider()];
  }
}
