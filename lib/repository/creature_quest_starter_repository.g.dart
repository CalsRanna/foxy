// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_quest_starter_repository.dart';

mixin _CreatureQuestStarterRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureQuestStarter(CreatureQuestStarterKey key) async {
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
    final json = _prepareWriteJson(creatureQuestStarter.toJson());
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
    final json = _prepareWriteJson(creatureQuestStarter.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('creature_queststarter'),
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
    CreatureQuestStarterEntity creatureQuestStarter,
  ) async {}

  Future<void> _beforeUpdate(
    CreatureQuestStarterKey originalKey,
    CreatureQuestStarterEntity creatureQuestStarter,
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

  QueryBuilder _whereKey(QueryBuilder builder, CreatureQuestStarterKey key) {
    var query = builder;
    query = query.where('id', key.id);
    query = query.where('quest', key.quest);
    return query;
  }
}
