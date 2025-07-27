import 'package:flutter/material.dart';
import 'package:foxy/widget/window_button.dart';
import 'package:window_manager/window_manager.dart';

class BootstrapWindowHeader extends StatelessWidget {
  const BootstrapWindowHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var container = Container(
      alignment: Alignment.topRight,
      height: 50,
      child: WindowButton(),
    );
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (details) => windowManager.startDragging(),
      child: container,
    );
  }
}
