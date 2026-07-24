// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_spell_repository.dart';

mixin _CreatureTemplateSpellRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureTemplateSpell(
    CreatureTemplateSpellKey key,
  ) async {
    final deletedRows = await _whereKey(
      laconic.table('creature_template_spell'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureTemplateSpellEntity?> getCreatureTemplateSpell(
    CreatureTemplateSpellKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('creature_template_spell'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureTemplateSpellEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureTemplateSpell(
    CreatureTemplateSpellEntity creatureTemplateSpell,
  ) async {
    await _beforeStore(creatureTemplateSpell);
    final json = _prepareWriteJson(creatureTemplateSpell.toJson());
    try {
      await laconic.table('creature_template_spell').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureTemplateSpell(
    CreatureTemplateSpellKey originalKey,
    CreatureTemplateSpellEntity creatureTemplateSpell,
  ) async {
    await _beforeUpdate(originalKey, creatureTemplateSpell);
    final json = _prepareWriteJson(creatureTemplateSpell.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('creature_template_spell'),
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

  Future<void> _beforeStore(
    CreatureTemplateSpellEntity creatureTemplateSpell,
  ) async {}

  Future<void> _beforeUpdate(
    CreatureTemplateSpellKey originalKey,
    CreatureTemplateSpellEntity creatureTemplateSpell,
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

  QueryBuilder _whereKey(QueryBuilder builder, CreatureTemplateSpellKey key) {
    var query = builder;
    query = query.where('CreatureID', key.creatureID);
    query = query.where('`Index`', key.index);
    return query;
  }
}
