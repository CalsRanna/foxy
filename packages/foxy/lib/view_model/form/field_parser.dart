/// Numeric parsing shared by form field controllers.
abstract final class FieldParser {
  /// Floating-point field parsing; same semantics as [parseIntField].
  static double parseDoubleField(String text, {String field = ''}) {
    final s = text.trim();
    if (s.isEmpty) return 0.0;
    final v = double.tryParse(s);
    if (v == null) {
      final label = field.isEmpty ? '数值' : field;
      throw FormatException('invalid number for "$label": $text');
    }
    return v;
  }

  /// Form number-field parsing.
  ///
  /// - An empty string counts as `0` (consistent with game-data defaults)
  /// - Invalid input (e.g. `12a`) throws [FormatException]; callers should
  ///   block saving
  static int parseIntField(String text, {String field = ''}) {
    final s = text.trim();
    if (s.isEmpty) return 0;
    final v = int.tryParse(s);
    if (v == null) {
      final label = field.isEmpty ? '数值' : field;
      throw FormatException('invalid integer for "$label": $text');
    }
    return v;
  }
}
