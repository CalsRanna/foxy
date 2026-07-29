// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_spell_repository.dart';

mixin _CreatureTemplateSpellRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureTemplateSpell(
    CreatureTemplateSpellKey key,
  ) async {
    await _beforeDestroy(key);
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
    final json = prepareWriteJson(creatureTemplateSpell.toJson());
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
    final json = prepareWriteJson(creatureTemplateSpell.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('creature_template_spell'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<void> _beforeDestroy(CreatureTemplateSpellKey key) async {}

  Future<void> _beforeStore(
    CreatureTemplateSpellEntity creatureTemplateSpell,
  ) async {}

  Future<void> _beforeUpdate(
    CreatureTemplateSpellKey originalKey,
    CreatureTemplateSpellEntity creatureTemplateSpell,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, CreatureTemplateSpellKey key) {
    var query = builder;
    query = query.where('`CreatureID`', key.creatureID);
    query = query.where('`Index`', key.index);
    return query;
  }
}
