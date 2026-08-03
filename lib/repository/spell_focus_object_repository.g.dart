// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_focus_object_repository.dart';

final class SpellFocusObjectFilter {
  final String id;
  final String name;

  const SpellFocusObjectFilter({this.id = '', this.name = ''});

  factory SpellFocusObjectFilter.fromJson(Map<String, dynamic> json) {
    return SpellFocusObjectFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SpellFocusObjectFilter copyWith({String? id, String? name}) {
    return SpellFocusObjectFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _SpellFocusObjectRepositoryMixin
    on RepositoryMixin, DbcLocaleRepositoryMixin {
  Future<void> destroySpellFocusObject(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_spell_focus_object'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_spell_focus_object record not found',
      );
    }
  }

  Future<SpellFocusObjectEntity?> getSpellFocusObject(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_spell_focus_object'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellFocusObjectEntity.fromJson(results.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getSpellFocusObjectLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveSpellFocusObjectLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeSpellFocusObject(
    SpellFocusObjectEntity spellFocusObject,
  ) async {
    if (spellFocusObject.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(spellFocusObject);
    final json = prepareWriteJson(spellFocusObject.toJson());
    try {
      await laconic.table('foxy.dbc_spell_focus_object').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = spellFocusObject.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_spell_focus_object', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_spell_focus_object').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_spell_focus_object',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updateSpellFocusObject(
    int originalKey,
    SpellFocusObjectEntity spellFocusObject,
  ) async {
    await _beforeUpdate(originalKey, spellFocusObject);
    final json = prepareWriteJson(spellFocusObject.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_spell_focus_object'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_spell_focus_object',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_spell_focus_object record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(SpellFocusObjectEntity spellFocusObject) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SpellFocusObjectEntity spellFocusObject,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
