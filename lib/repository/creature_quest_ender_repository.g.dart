// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_quest_ender_repository.dart';

mixin _CreatureQuestEnderRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureQuestEnder(CreatureQuestEnderKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('creature_questender'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureQuestEnderEntity?> getCreatureQuestEnder(
    CreatureQuestEnderKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('creature_questender'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureQuestEnderEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureQuestEnder(
    CreatureQuestEnderEntity creatureQuestEnder,
  ) async {
    await _beforeStore(creatureQuestEnder);
    final json = prepareWriteJson(creatureQuestEnder.toJson());
    try {
      await laconic.table('creature_questender').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureQuestEnder(
    CreatureQuestEnderKey originalKey,
    CreatureQuestEnderEntity creatureQuestEnder,
  ) async {
    await _beforeUpdate(originalKey, creatureQuestEnder);
    final json = prepareWriteJson(creatureQuestEnder.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('creature_questender'),
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

  Future<void> _beforeDestroy(CreatureQuestEnderKey key) async {}

  Future<void> _beforeStore(
    CreatureQuestEnderEntity creatureQuestEnder,
  ) async {}

  Future<void> _beforeUpdate(
    CreatureQuestEnderKey originalKey,
    CreatureQuestEnderEntity creatureQuestEnder,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, CreatureQuestEnderKey key) {
    var query = builder;
    query = query.where('`id`', key.id);
    query = query.where('`quest`', key.quest);
    return query;
  }
}
