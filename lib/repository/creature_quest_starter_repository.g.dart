// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_quest_starter_repository.dart';

mixin _CreatureQuestStarterRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureQuestStarter(CreatureQuestStarterKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('creature_queststarter'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureQuestStarterEntity?> getCreatureQuestStarter(
    CreatureQuestStarterKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('creature_queststarter'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureQuestStarterEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureQuestStarter(
    CreatureQuestStarterEntity creatureQuestStarter,
  ) async {
    await _beforeStore(creatureQuestStarter);
    final json = prepareWriteJson(creatureQuestStarter.toJson());
    try {
      await laconic.table('creature_queststarter').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureQuestStarter(
    CreatureQuestStarterKey originalKey,
    CreatureQuestStarterEntity creatureQuestStarter,
  ) async {
    await _beforeUpdate(originalKey, creatureQuestStarter);
    final json = prepareWriteJson(creatureQuestStarter.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('creature_queststarter'),
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

  Future<void> _beforeDestroy(CreatureQuestStarterKey key) async {}

  Future<void> _beforeStore(
    CreatureQuestStarterEntity creatureQuestStarter,
  ) async {}

  Future<void> _beforeUpdate(
    CreatureQuestStarterKey originalKey,
    CreatureQuestStarterEntity creatureQuestStarter,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, CreatureQuestStarterKey key) {
    var query = builder;
    query = query.where('`id`', key.id);
    query = query.where('`quest`', key.quest);
    return query;
  }
}
