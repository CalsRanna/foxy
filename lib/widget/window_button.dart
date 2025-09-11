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
    var minimizeButton = IconButton(
      onPressed: () => windowManager.minimize(),
      icon: const Icon(HugeIcons.strokeRoundedMinusSign),
      visualDensity: VisualDensity.compact,
    );
    var maximizeButton = IconButton(
      onPressed: _toggleMaximize,
      icon: const Icon(HugeIcons.strokeRoundedFullScreen),
      visualDensity: VisualDensity.compact,
    );
    var closeButton = IconButton(
      onPressed: () => windowManager.close(),
      icon: const Icon(HugeIcons.strokeRoundedCancel01),
      visualDensity: VisualDensity.compact,
    );
    var row = Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [minimizeButton, maximizeButton, closeButton],
    );
    var iconThemeData = IconThemeData(size: 16);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: IconTheme(data: iconThemeData, child: row),
    );
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
