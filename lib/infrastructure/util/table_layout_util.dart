/// Table layout helpers shared by list/detail pages.
library;

import 'dart:math';

/// Available width for a flex (stretching) table column, computed as the
/// remaining space after the fixed columns.
///
/// When the window is narrower than the fixed columns' total width, the
/// leftover would be negative and `FixedTableSpanExtent` would misbehave;
/// the flex column then floors at [minWidth] (120, matching the standard
/// fixed column width). At or above the fixed total the behavior is
/// identical to the raw `maxWidth - fixedTotal` (the flex column stretches
/// with the window).
double flexColumnWidth(
  double maxWidth,
  double fixedTotal, {
  double minWidth = 120,
}) {
  return max(minWidth, maxWidth - fixedTotal);
}
