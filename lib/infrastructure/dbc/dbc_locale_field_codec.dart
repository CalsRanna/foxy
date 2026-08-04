import 'package:foxy/entity/dbc_locale.dart';

/// Bidirectional codec between the wide table's 16 language columns and the
/// editor's 16 row values.
///
/// - Only handles the 16 string columns of the current field group.
/// - Never reads or modifies `${columnPrefix}_Flags` or other fields.
class DbcLocaleFieldCodec {
  const DbcLocaleFieldCodec._();

  /// Decodes a database row into 16 [DbcLocaleFieldValue]s in fixed order.
  static List<DbcLocaleFieldValue> decode(
    DbcLocaleFieldDefinition field,
    Map<String, dynamic> row,
  ) {
    return [
      for (final locale in DbcLocale.values)
        DbcLocaleFieldValue(
          locale: locale,
          value: _asString(row[field.columnFor(locale)]),
        ),
    ];
  }

  /// Produces 16 empty-value rows (fixed order).
  static List<DbcLocaleFieldValue> empty() {
    return [
      for (final locale in DbcLocale.values)
        DbcLocaleFieldValue(locale: locale, value: ''),
    ];
  }

  /// Encodes the 16 edited rows into an update map containing only the
  /// language columns of the current field group.
  ///
  /// Rejects data with the wrong length, duplicates, or illegal ordering.
  static Map<String, dynamic> encode(
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> values,
  ) {
    if (values.length != DbcLocale.values.length) {
      throw ArgumentError(
        'expected ${DbcLocale.values.length} locale values, got ${values.length}',
      );
    }

    final seen = <int>{};
    final map = <String, dynamic>{};

    for (var i = 0; i < values.length; i++) {
      final item = values[i];
      final expected = DbcLocale.values[i];
      if (item.locale.index != expected.index) {
        throw ArgumentError(
          'invalid locale order: index $i expected ${expected.code}, got ${item.locale.code}',
        );
      }
      if (!seen.add(item.locale.index)) {
        throw ArgumentError('duplicate locale slot: ${item.locale.code}');
      }
      map[field.columnFor(item.locale)] = item.value;
    }

    return map;
  }

  static String _asString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }
}
