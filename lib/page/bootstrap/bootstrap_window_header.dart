import 'package:flutter/material.dart';
import 'package:foxy/widget/window_button.dart';
import 'package:window_manager/window_manager.dart';

class BootstrapWindowHeader extends StatelessWidget {
  const BootstrapWindowHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (details) => windowManager.startDragging(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [WindowButton()],
        ),
      ),
    );
  }
}
