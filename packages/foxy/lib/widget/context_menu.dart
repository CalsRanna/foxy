import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Context-menu toolkit, showing a ShadContextMenu at a given position.
abstract final class ContextMenu {
  /// Shows a context menu at the given position
  ///
  /// [context] - BuildContext
  /// [position] - menu position (global coordinates)
  /// [items] - menu items, using ShadContextMenuItem
  static void show({
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
              child: Container(color: Colors.transparent),
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
}
