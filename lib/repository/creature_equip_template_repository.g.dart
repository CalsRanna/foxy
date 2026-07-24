// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_equip_template_repository.dart';

mixin _CreatureEquipTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureEquipTemplate(
    CreatureEquipTemplateKey key,
  ) async {
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
    final json = _prepareWriteJson(creatureEquipTemplate.toJson());
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
    final json = _prepareWriteJson(creatureEquipTemplate.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('creature_equip_template'),
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
    CreatureEquipTemplateEntity creatureEquipTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    CreatureEquipTemplateKey originalKey,
    CreatureEquipTemplateEntity creatureEquipTemplate,
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

  QueryBuilder _whereKey(QueryBuilder builder, CreatureEquipTemplateKey key) {
    var query = builder;
    query = query.where('CreatureID', key.creatureID);
    query = query.where('ID', key.id);
    return query;
  }
}
