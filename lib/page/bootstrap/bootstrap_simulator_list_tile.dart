import 'package:flutter/material.dart';

class BootstrapSimulatorListTile extends StatefulWidget {
  final VoidCallback? onClick;
  final Widget child;
  const BootstrapSimulatorListTile({
    super.key,
    this.onClick,
    required this.child,
  });

  @override
  State<BootstrapSimulatorListTile> createState() =>
      _BootstrapSimulatorListTileState();
}

class _BootstrapSimulatorListTileState
    extends State<BootstrapSimulatorListTile> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var primary = colorScheme.primary;
    var primaryContainer = colorScheme.primaryContainer;
    var color = hover ? primary : primaryContainer;
    var boxDecoration = BoxDecoration(
      border: Border.all(color: color),
      color: color,
      shape: BoxShape.circle,
    );
    var container = Container(
      decoration: boxDecoration,
      padding: const EdgeInsets.all(32),
      child: widget.child,
    );
    var mouseRegion = MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() => hover = true),
      onExit: (event) => setState(() => hover = false),
      child: container,
    );
    return GestureDetector(onTap: widget.onClick, child: mouseRegion);
  }
}
