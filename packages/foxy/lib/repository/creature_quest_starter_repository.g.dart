// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_quest_starter_repository.dart';

mixin _CreatureQuestStarterRepositoryMixin on RepositoryMixin {
  String get _table => 'creature_queststarter';

  Future<CreatureQuestStarterKey> copyCreatureQuestStarter(
    CreatureQuestStarterKey key,
  ) async {
    final source = await getCreatureQuestStarter(key);
    if (source == null) {
      throw RecordNotFoundException('creature_queststarter record not found');
    }
    final blank = await createCreatureQuestStarter(source.quest);
    final copied = source.copyWith(id: blank.id, quest: blank.quest);
    await storeCreatureQuestStarter(copied);
    return CreatureQuestStarterKey.fromEntity(copied);
  }

  Future<int> countCreatureQuestStarters(int quest) async {
    return laconic.table(_table).where('`quest`', quest).count();
  }

  Future<CreatureQuestStarterEntity> createCreatureQuestStarter(
    int quest,
  ) async {
    return CreatureQuestStarterEntity(
      quest: quest,
      id: await nextMaxPlusOne(_table, '`id`', where: {'`quest`': quest}),
    );
  }

  Future<void> destroyCreatureQuestStarter(CreatureQuestStarterKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await trackActivityWrite(
      _table,
      beforeKey: activityKey(key),
      write: () => _whereKey(laconic.table(_table), key).delete(),
    );
    if (deletedRows == 0) {
      throw RecordNotFoundException('creature_queststarter record not found');
    }
  }

  Future<CreatureQuestStarterEntity?> getCreatureQuestStarter(
    CreatureQuestStarterKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureQuestStarterEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefCreatureQuestStarterEntity>> getBriefCreatureQuestStarters(
    int quest, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select(['`id`', '`quest`']);
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
      await trackActivityWrite(
        _table,
        afterKey: activityKey(
          CreatureQuestStarterKey.fromEntity(creatureQuestStarter),
        ),
        write: () => laconic.table(_table).insert([json]),
      );
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = creatureQuestStarter.copyWith(
        id: await nextMaxPlusOne(
          _table,
          '`id`',
          where: {'`quest`': creatureQuestStarter.quest},
        ),
      );
      try {
        await trackActivityWrite(
          _table,
          afterKey: activityKey(CreatureQuestStarterKey.fromEntity(retried)),
          write: () => laconic.table(_table).insert([
            prepareWriteJson(retried.toJson()),
          ]),
        );
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in creature_queststarter');
        }
        rethrow;
      }
    }
  }

  Future<void> updateCreatureQuestStarter(
    CreatureQuestStarterKey originalKey,
    CreatureQuestStarterEntity creatureQuestStarter,
  ) async {
    await _beforeUpdate(originalKey, creatureQuestStarter);
    final values = creatureQuestStarter.toJson();
    final json = prepareWriteJson(values);
    final int matchedRows;
    try {
      matchedRows = await trackActivityWrite(
        _table,
        beforeKey: activityKey(originalKey),
        afterKey: activityKey(
          CreatureQuestStarterKey.fromEntity(creatureQuestStarter),
        ),
        columns: values.keys,
        write: () => _whereKey(laconic.table(_table), originalKey).update(json),
      );
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in creature_queststarter');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('creature_queststarter record not found');
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

  Map<String, Object?> activityKey(CreatureQuestStarterKey key) => {
    'id': key.id,
    'quest': key.quest,
  };

  QueryBuilder _whereKey(QueryBuilder builder, CreatureQuestStarterKey key) {
    var query = builder;
    query = query.where('`id`', key.id);
    query = query.where('`quest`', key.quest);
    return query;
  }
}
