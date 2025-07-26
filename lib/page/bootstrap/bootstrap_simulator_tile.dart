import 'package:flutter/material.dart';

class BootstrapSimulatorTile extends StatefulWidget {
  final VoidCallback? onClick;
  final Widget child;
  const BootstrapSimulatorTile({super.key, this.onClick, required this.child});

  @override
  State<BootstrapSimulatorTile> createState() => _BootstrapSimulatorTileState();
}

class _BootstrapSimulatorTileState extends State<BootstrapSimulatorTile> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;
    final primaryContainer = colorScheme.primaryContainer;
    final color = hover ? primary : primaryContainer;
    return GestureDetector(
      onTap: widget.onClick,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) => setState(() => hover = true),
        onExit: (event) => setState(() => hover = false),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color),
          ),
          padding: const EdgeInsets.all(48),
          child: widget.child,
        ),
      ),
    );
  }
}
