// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_area_repository.dart';

mixin _SpellAreaRepositoryMixin on RepositoryMixin {
  Future<void> destroySpellArea(SpellAreaKey key) async {
    final deletedRows = await _whereKey(
      laconic.table('spell_area'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<SpellAreaEntity?> getSpellArea(SpellAreaKey key) async {
    final results = await _whereKey(
      laconic.table('spell_area'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellAreaEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSpellArea(SpellAreaEntity spellArea) async {
    await _beforeStore(spellArea);
    final json = _prepareWriteJson(spellArea.toJson());
    try {
      await laconic.table('spell_area').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSpellArea(
    SpellAreaKey originalKey,
    SpellAreaEntity spellArea,
  ) async {
    await _beforeUpdate(originalKey, spellArea);
    final json = _prepareWriteJson(spellArea.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('spell_area'),
        originalKey,
      ).update(json);
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
  }

  Future<void> _beforeStore(SpellAreaEntity spellArea) async {}

  Future<void> _beforeUpdate(
    SpellAreaKey originalKey,
    SpellAreaEntity spellArea,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    return {
      for (final entry in json.entries)
        if (const {'index', 'rank'}.contains(entry.key.toLowerCase()))
          '`${entry.key}`': entry.value
        else
          entry.key: entry.value,
    };
  }

  QueryBuilder _whereKey(QueryBuilder builder, SpellAreaKey key) {
    var query = builder;
    query = query.where('spell', key.spell);
    query = query.where('area', key.area);
    query = query.where('quest_start', key.questStart);
    query = query.where('aura_spell', key.auraSpell);
    query = query.where('racemask', key.racemask);
    query = query.where('gender', key.gender);
    return query;
  }
}
