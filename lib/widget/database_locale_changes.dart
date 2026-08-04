import 'package:flutter/foundation.dart';

@immutable
final class DatabaseLocaleChanges {
  final List<DatabaseLocaleRow> rows;
  final List<String> deletedLocales;

  const DatabaseLocaleChanges({
    required this.rows,
    required this.deletedLocales,
  });
}

/// A regular database locale edit row.
///
/// [originalLocale] is the locale when opening the editor on an existing
/// row; null for new rows. Even if the user changes the locale inside
/// [values], this stays untouched, letting the domain delegate build the
/// original strongly-typed Key.
@immutable
final class DatabaseLocaleRow {
  final String? originalLocale;
  final Map<String, String> values;

  const DatabaseLocaleRow({required this.originalLocale, required this.values});

  factory DatabaseLocaleRow.persisted(Map<String, String> values) {
    return DatabaseLocaleRow(
      originalLocale: values['locale'],
      values: Map.unmodifiable(values),
    );
  }
}
