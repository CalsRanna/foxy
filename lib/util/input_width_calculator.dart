import 'package:flutter/material.dart';

class InputWidthCalculator {
  final BuildContext context;
  final double wrapSpacing;

  InputWidthCalculator(this.context, {this.wrapSpacing = 8});

  double calculate() {
    double width = _getAvailableWidth();
    final count = _getColumnCount(width);
    final totalSpacing = wrapSpacing * (count - 1);
    return ((width - totalSpacing) / count).floorToDouble();
  }

  int _getColumnCount(double width) {
    if (width <= 1000) return 3;
    if (width <= 1200) return 4;
    return 5;
  }

  double _getAvailableWidth() {
    const leftBarWidth = 80.0;
    const dividerWidth = 1.0;
    const workspacePadding = 16.0 * 2;
    const cardPadding = 16.0 * 2;
    const scrollbarWidth = 16.0; // ListView 滚动条宽度
    final screenWidth = MediaQuery.sizeOf(context).width;
    return screenWidth -
        leftBarWidth -
        dividerWidth -
        workspacePadding -
        cardPadding -
        scrollbarWidth;
  }
}
