import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:window_manager/window_manager.dart';

class WindowButton extends StatefulWidget {
  const WindowButton({super.key});

  @override
  State<WindowButton> createState() => _WindowButtonState();
}

class _WindowButtonState extends State<WindowButton> with WindowListener {
  var isMaximized = false;

  @override
  void initState() {
    super.initState();
    // Maximize-state changes from other paths (system snap Win+Up,
    // taskbar actions) must sync too, or the button state drifts (a
    // re-click would perform the reverse action).
    windowManager.addListener(this);
    windowManager.isMaximized().then((value) {
      if (mounted) setState(() => isMaximized = value);
    });
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowMaximize() {
    setState(() => isMaximized = true);
  }

  @override
  void onWindowUnmaximize() {
    setState(() => isMaximized = false);
  }

  @override
  Widget build(BuildContext context) {
    var minimizeButton = IconButton(
      onPressed: () => windowManager.minimize(),
      icon: const Icon(LucideIcons.minus),
      visualDensity: VisualDensity.compact,
    );
    var maximizeButton = IconButton(
      onPressed: _toggleMaximize,
      icon: Icon(isMaximized ? LucideIcons.copy : LucideIcons.maximize),
      visualDensity: VisualDensity.compact,
    );
    var closeButton = IconButton(
      onPressed: () => windowManager.close(),
      icon: const Icon(LucideIcons.x),
      visualDensity: VisualDensity.compact,
    );
    var row = Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [minimizeButton, maximizeButton, closeButton],
    );
    var iconThemeData = IconThemeData(size: 16);
    return IconTheme(data: iconThemeData, child: row);
  }

  void _toggleMaximize() {
    if (isMaximized) {
      windowManager.unmaximize();
    } else {
      windowManager.maximize();
    }
    // State is written back by the onWindowMaximize/onWindowUnmaximize
    // events; we no longer flip it ourselves, avoiding a race with event
    // arrival order.
  }
}
