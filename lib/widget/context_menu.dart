import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 在指定位置显示上下文菜单
///
/// [context] - BuildContext
/// [position] - 菜单显示位置（全局坐标）
/// [items] - 菜单项列表，使用 ShadContextMenuItem
void showFoxyContextMenu({
  required BuildContext context,
  required Offset position,
  required List<Widget> items,
}) {
  final overlay = Overlay.of(context, rootOverlay: true);
  late OverlayEntry entry;
  final controller = ShadContextMenuController(isOpen: true);

  void removeEntry() {
    if (entry.mounted) {
      entry.remove();
    }
    controller.dispose();
  }

  controller.addListener(() {
    if (!controller.isOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        removeEntry();
      });
    }
  });

  entry = OverlayEntry(
    builder: (context) => Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () => controller.hide(),
            onSecondaryTap: () => controller.hide(),
            behavior: HitTestBehavior.translucent,
          ),
        ),
        Positioned(
          left: position.dx,
          top: position.dy,
          child: ShadContextMenu(
            controller: controller,
            anchor: const ShadAnchorAuto(
              followerAnchor: Alignment.bottomRight,
              targetAnchor: Alignment.topLeft,
            ),
            items: items,
            child: const SizedBox.shrink(),
          ),
        ),
      ],
    ),
  );

  overlay.insert(entry);
}
