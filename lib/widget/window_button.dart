import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:window_manager/window_manager.dart';

class WindowButton extends StatefulWidget {
  const WindowButton({super.key});

  @override
  State<WindowButton> createState() => _WindowButtonState();
}

class _WindowButtonState extends State<WindowButton> {
  var isMaximized = false;

  @override
  Widget build(BuildContext context) {
    var children = [
      IconButton(
        onPressed: () => windowManager.minimize(),
        icon: const Icon(HugeIcons.strokeRoundedMinimize01),
      ),
      IconButton(
        onPressed: _toggleMaximize,
        icon: const Icon(HugeIcons.strokeRoundedMaximize01),
      ),
      IconButton(
        onPressed: () => windowManager.close(),
        icon: const Icon(HugeIcons.strokeRoundedCancel01),
      ),
    ];
    var row = Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: children,
    );
    return Padding(padding: const EdgeInsets.all(4.0), child: row);
  }

  void _toggleMaximize() {
    if (isMaximized) {
      windowManager.unmaximize();
    } else {
      windowManager.maximize();
    }
    isMaximized = !isMaximized;
  }
}
