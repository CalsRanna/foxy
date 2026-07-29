// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_equip_template_repository.dart';

mixin _CreatureEquipTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureEquipTemplate(
    CreatureEquipTemplateKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('creature_equip_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureEquipTemplateEntity?> getCreatureEquipTemplate(
    CreatureEquipTemplateKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('creature_equip_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureEquipTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureEquipTemplate(
    CreatureEquipTemplateEntity creatureEquipTemplate,
  ) async {
    await _beforeStore(creatureEquipTemplate);
    final json = prepareWriteJson(creatureEquipTemplate.toJson());
    try {
      await laconic.table('creature_equip_template').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureEquipTemplate(
    CreatureEquipTemplateKey originalKey,
    CreatureEquipTemplateEntity creatureEquipTemplate,
  ) async {
    await _beforeUpdate(originalKey, creatureEquipTemplate);
    final json = prepareWriteJson(creatureEquipTemplate.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('creature_equip_template'),
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

  Future<void> _beforeDestroy(CreatureEquipTemplateKey key) async {}

  Future<void> _beforeStore(
    CreatureEquipTemplateEntity creatureEquipTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    CreatureEquipTemplateKey originalKey,
    CreatureEquipTemplateEntity creatureEquipTemplate,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, CreatureEquipTemplateKey key) {
    var query = builder;
    query = query.where('`CreatureID`', key.creatureID);
    query = query.where('`ID`', key.id);
    return query;
  }
}
