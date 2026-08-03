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
    // 系统吸附(Win+↑)、任务栏操作等途径改变的最大化状态同样需要同步,
    // 否则按钮状态失步(再点会执行反向操作)。
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
    // 状态由 onWindowMaximize/onWindowUnmaximize 事件回写,这里不再自行
    // 翻转,避免与事件到达顺序竞争。
  }
}
