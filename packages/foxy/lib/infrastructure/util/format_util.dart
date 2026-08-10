/// Number formatting utilities.
///
/// [formatNum] converts a number to a string, trimming trailing zeros
/// after the decimal point for doubles (e.g. `1.50 → 1.5`, `2.0 → 2`).
/// Integers are output as-is.
///
/// Scientific notation (containing `e`/`E`) keeps Dart's native rendering,
/// avoiding trimming trailing zeros in the exponent (e.g. `1.5e-10` must
/// not become `1.5e-1`).
///
/// This logic used to be duplicated as private `_fmt`/`_format` helpers
/// across ~60 view models, recompiling two RegExps on every call. This file
/// centralizes one implementation and uses manual trimming (no regex) to
/// remove the per-call compilation cost — every numeric field invokes it
/// while populating a detail form, which adds up noticeably.
abstract final class FormatUtil {
  static String formatNum(num v) {
    if (v is! double) return v.toString();
    final s = v.toString();
    // Scientific notation: the exponent may end in 0 (e.g. e-10, e+30), so
    // never trim zeros from the end of the whole string.
    if (s.contains('e') || s.contains('E')) return s;
    // Only "x.y...0" shapes need trimming; otherwise (no decimal point, or
    // not ending in 0) return as-is.
    final dot = s.indexOf('.');
    if (dot < 0 || !s.endsWith('0')) return s;
    // Trim redundant zeros from the end; if the fractional part is all
    // zeros, drop the decimal point too.
    var end = s.length;
    while (end > dot + 1 && s.codeUnitAt(end - 1) == 0x30) {
      end--;
    }
    if (end == dot + 1)
      end = dot; // fractional part trimmed away → drop the dot
    return s.substring(0, end);
  }
}
