// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_group_repository.dart';

mixin _SpellGroupRepositoryMixin on RepositoryMixin {
  Future<void> destroySpellGroup(SpellGroupKey key) async {
    final deletedRows = await _whereKey(
      laconic.table('spell_group'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<SpellGroupEntity?> getSpellGroup(SpellGroupKey key) async {
    final results = await _whereKey(
      laconic.table('spell_group'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellGroupEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSpellGroup(SpellGroupEntity spellGroup) async {
    await _beforeStore(spellGroup);
    final json = _prepareWriteJson(spellGroup.toJson());
    try {
      await laconic.table('spell_group').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSpellGroup(
    SpellGroupKey originalKey,
    SpellGroupEntity spellGroup,
  ) async {
    await _beforeUpdate(originalKey, spellGroup);
    final json = _prepareWriteJson(spellGroup.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('spell_group'),
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

  Future<void> _beforeStore(SpellGroupEntity spellGroup) async {}

  Future<void> _beforeUpdate(
    SpellGroupKey originalKey,
    SpellGroupEntity spellGroup,
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

  QueryBuilder _whereKey(QueryBuilder builder, SpellGroupKey key) {
    var query = builder;
    query = query.where('id', key.id);
    query = query.where('spell_id', key.spellId);
    return query;
  }
}
