import 'package:flutter/material.dart';

class InputWidthCalculator {
  final BuildContext context;

  InputWidthCalculator(this.context);

  double calculate() {
    final mediaQuery = MediaQuery.of(context);
    double width = _getWidth(mediaQuery);
    final length = _getLength(width);
    final spaceWidth = 8 * (length - 1);
    return (width - spaceWidth) / length;
  }

  double _getWidth(MediaQueryData mediaQuery) {
    const leftBarWidth = 80;
    const dividerWidth = 1;
    const workspacePaddingWidth = 16 * 2;
    const cardPaddingWidth = 16 * 2;
    double width = mediaQuery.size.width;
    width -= leftBarWidth;
    width -= dividerWidth;
    width -= workspacePaddingWidth;
    width -= cardPaddingWidth;
    return width;
  }

  int _getLength(double width) {
    int length = 5;
    if (width <= 1200) length = 4;
    if (width <= 1000) length = 3;
    return length;
  }
}
