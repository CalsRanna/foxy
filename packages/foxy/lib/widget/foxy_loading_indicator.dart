import 'package:flutter/material.dart';

/// Uniform loading indicator for the whole app.
///
/// Previously every site hand-rolled a `SizedBox.square` plus
/// `CircularProgressIndicator` with its own size/stroke combination
/// (28/3, 28/2.5, 24/2, 20/2). This is the single spinner entry point;
/// use the default size in new code and only override for cramped
/// contexts (e.g. 20 inside a table row).
class FoxyLoadingIndicator extends StatelessWidget {
  final double size;
  final double strokeWidth;

  const FoxyLoadingIndicator({super.key, this.size = 24, this.strokeWidth = 2});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(strokeWidth: strokeWidth),
    );
  }
}
