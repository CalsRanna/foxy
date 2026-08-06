// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_icon_repository.dart';

final class SpellIconFilter {
  final String id;
  final String name;

  const SpellIconFilter({this.id = '', this.name = ''});

  factory SpellIconFilter.fromJson(Map<String, dynamic> json) {
    return SpellIconFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SpellIconFilter copyWith({String? id, String? name}) {
    return SpellIconFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _SpellIconRepositoryMixin on RepositoryMixin {
  Future<void> destroySpellIcon(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_spell_icon'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_spell_icon record not found');
    }
  }

  Future<SpellIconEntity?> getSpellIcon(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_spell_icon'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellIconEntity.fromJson(results.first.toMap());
  }

  Future<int> storeSpellIcon(SpellIconEntity spellIcon) async {
    if (spellIcon.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(spellIcon);
    final json = prepareWriteJson(spellIcon.toJson());
    try {
      await laconic.table('foxy.dbc_spell_icon').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = spellIcon.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_spell_icon', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_spell_icon').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_spell_icon');
        }
        rethrow;
      }
    }
    return spellIcon.id;
  }

  Future<void> updateSpellIcon(
    int originalKey,
    SpellIconEntity spellIcon,
  ) async {
    await _beforeUpdate(originalKey, spellIcon);
    final json = prepareWriteJson(spellIcon.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_spell_icon'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_spell_icon');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_spell_icon record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(SpellIconEntity spellIcon) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SpellIconEntity spellIcon,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
