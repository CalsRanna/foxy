// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_quest_item_repository.dart';

mixin _CreatureQuestItemRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureQuestItem(CreatureQuestItemKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('creature_questitem'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureQuestItemEntity?> getCreatureQuestItem(
    CreatureQuestItemKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('creature_questitem'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureQuestItemEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureQuestItem(
    CreatureQuestItemEntity creatureQuestItem,
  ) async {
    await _beforeStore(creatureQuestItem);
    final json = prepareWriteJson(creatureQuestItem.toJson());
    try {
      await laconic.table('creature_questitem').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureQuestItem(
    CreatureQuestItemKey originalKey,
    CreatureQuestItemEntity creatureQuestItem,
  ) async {
    await _beforeUpdate(originalKey, creatureQuestItem);
    final json = prepareWriteJson(creatureQuestItem.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('creature_questitem'),
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

  Future<void> _beforeDestroy(CreatureQuestItemKey key) async {}

  Future<void> _beforeStore(CreatureQuestItemEntity creatureQuestItem) async {}

  Future<void> _beforeUpdate(
    CreatureQuestItemKey originalKey,
    CreatureQuestItemEntity creatureQuestItem,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, CreatureQuestItemKey key) {
    var query = builder;
    query = query.where('`CreatureEntry`', key.creatureEntry);
    query = query.where('`Idx`', key.idx);
    return query;
  }
}
