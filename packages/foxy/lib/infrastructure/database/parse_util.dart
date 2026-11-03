/// SQL text helpers shared by repositories.
abstract final class ParseUtil {
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
  static String escapeLike(String value) => value
      .replaceAll('\\', '\\\\')
      .replaceAll('%', '\\%')
      .replaceAll('_', '\\_');
}
