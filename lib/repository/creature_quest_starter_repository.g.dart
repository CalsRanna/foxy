// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_quest_starter_repository.dart';

mixin _CreatureQuestStarterRepositoryMixin on RepositoryMixin {
  Future<CreatureQuestStarterKey> copyCreatureQuestStarter(
    CreatureQuestStarterKey key,
  ) async {
    final source = await getCreatureQuestStarter(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createCreatureQuestStarter(source.quest);
    final copied = source.copyWith(id: blank.id, quest: blank.quest);
    await storeCreatureQuestStarter(copied);
    return CreatureQuestStarterKey.fromEntity(copied);
  }

  Future<int> countCreatureQuestStarters(int quest) async {
    return laconic
        .table('creature_queststarter')
        .where('`quest`', quest)
        .count();
  }

  Future<CreatureQuestStarterEntity> createCreatureQuestStarter(
    int quest,
  ) async {
    return CreatureQuestStarterEntity(
      quest: quest,
      id: await nextMaxPlusOne(
        'creature_queststarter',
        '`id`',
        where: {'quest': quest},
      ),
    );
  }

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

  Future<List<BriefCreatureQuestStarterEntity>> getBriefCreatureQuestStarters(
    int quest, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('creature_queststarter').select([
      '`id`',
      '`quest`',
    ]);
    builder = builder.where('`quest`', quest);
    builder = builder.orderBy('`id`').orderBy('`quest`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefCreatureQuestStarterEntity.fromJson(e.toMap()))
        .toList();
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
