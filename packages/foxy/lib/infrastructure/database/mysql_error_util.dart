import 'package:laconic/laconic.dart';

/// MySQL driver error classification utilities.
///
/// laconic fills [LaconicException.driver] and [LaconicException.code] with
/// structured values at the driver boundary, so classification is a plain
/// field comparison — no message parsing.
///
/// Kept as a dedicated symbol because the repository code generator emits
/// [isDuplicateEntry] across all generated repositories.
abstract final class MysqlErrorUtil {
  /// MySQL server error code for a duplicate entry (ER_DUP_ENTRY).
  static const duplicateEntryCode = '1062';

  /// Whether [error] is a duplicate-entry error reported by the MySQL
  /// driver. Errors from other drivers or without structured fields never
  /// match, even if their message mentions `1062`.
  static bool isDuplicateEntry(Object error) =>
      error is LaconicException &&
      error.driver == 'mysql' &&
      error.code == duplicateEntryCode;
}
