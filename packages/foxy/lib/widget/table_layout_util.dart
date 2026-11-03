import 'dart:math';

/// Table layout helpers shared by list/detail pages.
abstract final class TableLayoutUtil {
  /// Available width for a flex (stretching) table column, computed as the
  /// remaining space after the fixed columns.
  ///
  /// When the window is narrower than the fixed columns' total width, the
  /// leftover would be negative and `FixedTableSpanExtent` would misbehave;
  /// the flex column then floors at [minWidth] (120, matching the standard
  /// fixed column width). At or above the fixed total the behavior is
  /// identical to the raw `maxWidth - fixedTotal` (the flex column stretches
  /// with the window).
  static double flexColumnWidth(
    double maxWidth,
    double fixedTotal, {
    double minWidth = 120,
  }) {
    return max(minWidth, maxWidth - fixedTotal);
  }

  /// Maximum number of badges (with widths [widths]) that fit into [maxWidth]
  /// when the remaining ones are collapsed into a trailing `+N` badge.
  ///
  /// Each badge is separated by [spacing]; [moreWidth] returns the `+N` badge
  /// width for a given hidden count (the label depends on N). Returns 0 when
  /// even a single badge together with its `+N` does not fit.
  static int fittingBadgeCount(
    List<double> widths,
    double Function(int hidden) moreWidth,
    double spacing,
    double maxWidth,
  ) {
    final n = widths.length;
    var total = 0.0;
    for (var count = 1; count <= n; count++) {
      total += widths[count - 1];
      if (count > 1) total += spacing;
      final hidden = n - count;
      final withMore = total + (hidden > 0 ? spacing + moreWidth(hidden) : 0);
      if (withMore > maxWidth) return count - 1;
    }
    return n;
  }
}
