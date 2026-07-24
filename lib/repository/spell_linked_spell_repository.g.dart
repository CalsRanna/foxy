// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_linked_spell_repository.dart';

mixin _SpellLinkedSpellRepositoryMixin on RepositoryMixin {
  Future<void> destroySpellLinkedSpell(SpellLinkedSpellKey key) async {
    final deletedRows = await _whereKey(
      laconic.table('spell_linked_spell'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<SpellLinkedSpellEntity?> getSpellLinkedSpell(
    SpellLinkedSpellKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('spell_linked_spell'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellLinkedSpellEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSpellLinkedSpell(
    SpellLinkedSpellEntity spellLinkedSpell,
  ) async {
    await _beforeStore(spellLinkedSpell);
    final json = _prepareWriteJson(spellLinkedSpell.toJson());
    try {
      await laconic.table('spell_linked_spell').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSpellLinkedSpell(
    SpellLinkedSpellKey originalKey,
    SpellLinkedSpellEntity spellLinkedSpell,
  ) async {
    await _beforeUpdate(originalKey, spellLinkedSpell);
    final json = _prepareWriteJson(spellLinkedSpell.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('spell_linked_spell'),
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

  Future<void> _beforeStore(SpellLinkedSpellEntity spellLinkedSpell) async {}

  Future<void> _beforeUpdate(
    SpellLinkedSpellKey originalKey,
    SpellLinkedSpellEntity spellLinkedSpell,
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

  QueryBuilder _whereKey(QueryBuilder builder, SpellLinkedSpellKey key) {
    var query = builder;
    query = query.where('spell_trigger', key.spellTrigger);
    query = query.where('spell_effect', key.spellEffect);
    query = query.where('type', key.type);
    return query;
  }
}
