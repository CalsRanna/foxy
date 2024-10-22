import 'package:flutter/material.dart';

class FoxyBreadcrumb extends StatelessWidget {
  final List<Widget> children;
  const FoxyBreadcrumb({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [];
    final separator = _buildSeparator();
    for (var i = 0; i < children.length; i++) {
      items.add(children[i]);
      if (i < children.length - 1) items.add(separator);
    }
    return Row(children: items);
  }

  Widget _buildSeparator() {
    const edgeInsets = EdgeInsets.all(4);
    return Padding(padding: edgeInsets, child: Text('/'));
  }
}

class FoxyBreadcrumbItem extends StatelessWidget {
  final Function()? onTap;
  final Widget child;
  const FoxyBreadcrumbItem({super.key, this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final onSurface = colorScheme.onSurface;
    final disabled = onTap == null;
    final opacity = disabled ? 1.0 : 0.5;
    final textStyle = TextStyle(color: onSurface.withOpacity(opacity));
    final item = DefaultTextStyle.merge(child: child, style: textStyle);
    const edgeInsets = EdgeInsets.all(4);
    final padding = Padding(padding: edgeInsets, child: item);
    final borderRadius = BorderRadius.circular(4);
    return InkWell(borderRadius: borderRadius, onTap: onTap, child: padding);
  }
}
