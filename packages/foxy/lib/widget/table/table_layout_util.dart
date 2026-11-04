/// Table layout helpers shared by list/detail pages.
abstract final class TableLayoutUtil {
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
