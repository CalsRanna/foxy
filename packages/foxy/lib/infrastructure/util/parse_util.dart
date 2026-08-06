/// Escapes wildcards in LIKE patterns so filter values match literally.
///
/// MySQL defaults to `\` as the escape character (no ESCAPE clause
/// needed); laconic only binds parameters and never escapes `%`/`_` for
/// callers, so user input containing such characters (e.g. `100%`) would
/// act as wildcards and match many unrelated records.
///
/// Precondition: MySQL `NO_BACKSLASH_ESCAPES` must be OFF (the default).
/// Under that mode `\%` degrades to "literal backslash + wildcard %" and
/// the filter falls back to approximate matching (all values are still
/// parameter-bound, so there is no injection risk — only filter precision
/// suffers).
String escapeLike(String value) => value
    .replaceAll('\\', '\\\\')
    .replaceAll('%', '\\%')
    .replaceAll('_', '\\_');

/// Floating-point field parsing; same semantics as [parseIntField].
double parseDoubleField(String text, {String field = ''}) {
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
int parseIntField(String text, {String field = ''}) {
  final s = text.trim();
  if (s.isEmpty) return 0;
  final v = int.tryParse(s);
  if (v == null) {
    final label = field.isEmpty ? '数值' : field;
    throw FormatException('invalid integer for "$label": $text');
  }
  return v;
}
