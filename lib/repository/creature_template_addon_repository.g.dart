// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_addon_repository.dart';

mixin _CreatureTemplateAddonRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureTemplateAddon(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('creature_template_addon'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureTemplateAddonEntity?> getCreatureTemplateAddon(int key) async {
    final results = await _whereKey(
      laconic.table('creature_template_addon'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureTemplateAddonEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureTemplateAddon(
    CreatureTemplateAddonEntity creatureTemplateAddon,
  ) async {
    if (creatureTemplateAddon.entry <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(creatureTemplateAddon);
    final json = _prepareWriteJson(creatureTemplateAddon.toJson());
    try {
      await laconic.table('creature_template_addon').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureTemplateAddon(
    int originalKey,
    CreatureTemplateAddonEntity creatureTemplateAddon,
  ) async {
    await _beforeUpdate(originalKey, creatureTemplateAddon);
    final json = _prepareWriteJson(creatureTemplateAddon.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('creature_template_addon'),
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
    CreatureTemplateAddonEntity creatureTemplateAddon,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CreatureTemplateAddonEntity creatureTemplateAddon,
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

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('entry', key);
  }
}
