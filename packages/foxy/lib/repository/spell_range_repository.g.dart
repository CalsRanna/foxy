// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_range_repository.dart';

final class SpellRangeFilter {
  final String id;
  final String name;

  const SpellRangeFilter({this.id = '', this.name = ''});

  factory SpellRangeFilter.fromJson(Map<String, dynamic> json) {
    return SpellRangeFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SpellRangeFilter copyWith({String? id, String? name}) {
    return SpellRangeFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _SpellRangeRepositoryMixin on RepositoryMixin, DbcLocaleRepositoryMixin {
  Future<void> destroySpellRange(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_spell_range record not found');
    }
  }

  Future<SpellRangeEntity?> getSpellRange(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellRangeEntity.fromJson(results.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getSpellRangeLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveSpellRangeLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> storeSpellRange(SpellRangeEntity spellRange) async {
    if (spellRange.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(spellRange);
    final json = prepareWriteJson(spellRange.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = spellRange.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_spell_range');
        }
        rethrow;
      }
    }
    return spellRange.id;
  }

  Future<void> updateSpellRange(
    int originalKey,
    SpellRangeEntity spellRange,
  ) async {
    await _beforeUpdate(originalKey, spellRange);
    final json = prepareWriteJson(spellRange.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_spell_range');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_spell_range record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(SpellRangeEntity spellRange) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SpellRangeEntity spellRange,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}

const _table = 'foxy.dbc_spell_range';
