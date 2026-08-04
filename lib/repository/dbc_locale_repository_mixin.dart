import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/infrastructure/dbc/dbc_locale_field_codec.dart';
import 'package:foxy/repository/repository_mixin.dart';

/// Load/partial-update implementation for DBC wide-table locale fields.
///
/// Each DBC Repository mixes in this and exposes table-named
/// `get*Locales` / `save*Locales` methods; pages must never bypass the
/// Repository to touch Laconic directly.
mixin DbcLocaleRepositoryMixin on RepositoryMixin {
  /// Fully-qualified table name, e.g. `foxy.dbc_spell`.
  String get dbcLocaleTableName;

  /// Table name with the `foxy.` prefix stripped, aligned with
  /// [DbcLocaleFieldDefinition.tableName].
  String get _unqualifiedDbcTableName {
    final name = dbcLocaleTableName;
    const prefix = 'foxy.';
    return name.startsWith(prefix) ? name.substring(prefix.length) : name;
  }

  /// Loads the 16 language values of a locale field on the given record.
  ///
  /// Throws [StateError] when the record does not exist, so an empty value
  /// never masks a wrong ID.
  Future<List<DbcLocaleFieldValue>> loadDbcLocaleField(
    int id,
    DbcLocaleFieldDefinition field,
  ) async {
    _ensureFieldBelongsToTable(field);
    final results = await laconic
        .table(dbcLocaleTableName)
        .select(field.columnNames)
        .where('ID', id)
        .limit(1)
        .get();
    if (results.isEmpty) {
      throw RecordNotFoundException(
        'DBC record not found: $dbcLocaleTableName ID=$id',
      );
    }
    return DbcLocaleFieldCodec.decode(field, results.first.toMap());
  }

  /// Partially updates the 16 language columns of a locale field (leaves
  /// Flags and other fields untouched).
  ///
  /// Before updating, validates the field belongs to this table and the
  /// record exists; laconic's update does not return an affected-row count,
  /// so an existence check replaces the silent success of a 0-row UPDATE.
  Future<void> storeDbcLocaleField(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> values,
  ) async {
    _ensureFieldBelongsToTable(field);
    await _ensureRecordExists(id);
    final update = DbcLocaleFieldCodec.encode(field, values);
    await laconic.table(dbcLocaleTableName).where('ID', id).update(update);
  }

  void _ensureFieldBelongsToTable(DbcLocaleFieldDefinition field) {
    final expected = _unqualifiedDbcTableName;
    if (field.tableName != expected && field.tableName != dbcLocaleTableName) {
      throw ArgumentError(
        'field ${field.columnPrefix} belongs to table ${field.tableName}, '
        'which does not match the current repository table $dbcLocaleTableName',
      );
    }
  }

  Future<void> _ensureRecordExists(int id) async {
    final count = await laconic
        .table(dbcLocaleTableName)
        .where('ID', id)
        .count();
    if (count == 0) {
      throw RecordNotFoundException(
        'DBC record not found, cannot save locale: $dbcLocaleTableName ID=$id',
      );
    }
  }
}
