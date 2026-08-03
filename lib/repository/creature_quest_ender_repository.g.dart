// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_quest_ender_repository.dart';

mixin _CreatureQuestEnderRepositoryMixin on RepositoryMixin {
  Future<CreatureQuestEnderKey> copyCreatureQuestEnder(
    CreatureQuestEnderKey key,
  ) async {
    final source = await getCreatureQuestEnder(key);
    if (source == null) {
      throw RecordNotFoundException('creature_questender record not found');
    }
    final blank = await createCreatureQuestEnder(source.quest);
    final copied = source.copyWith(id: blank.id, quest: blank.quest);
    await storeCreatureQuestEnder(copied);
    return CreatureQuestEnderKey.fromEntity(copied);
  }

  Future<int> countCreatureQuestEnders(int quest) async {
    return laconic.table('creature_questender').where('`quest`', quest).count();
  }

  Future<CreatureQuestEnderEntity> createCreatureQuestEnder(int quest) async {
    return CreatureQuestEnderEntity(
      quest: quest,
      id: await nextMaxPlusOne(
        'creature_questender',
        '`id`',
        where: {'quest': quest},
      ),
    );
  }

  Future<void> destroyCreatureQuestEnder(CreatureQuestEnderKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('creature_questender'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('creature_questender record not found');
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

  Future<List<BriefCreatureQuestEnderEntity>> getBriefCreatureQuestEnders(
    int quest, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('creature_questender').select([
      '`id`',
      '`quest`',
    ]);
    builder = builder.where('`quest`', quest);
    builder = builder.orderBy('`id`').orderBy('`quest`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefCreatureQuestEnderEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeCreatureQuestEnder(
    CreatureQuestEnderEntity creatureQuestEnder,
  ) async {
    await _beforeStore(creatureQuestEnder);
    final json = prepareWriteJson(creatureQuestEnder.toJson());
    try {
      await laconic.table('creature_questender').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = creatureQuestEnder.copyWith(
        id: await nextMaxPlusOne(
          'creature_questender',
          '`id`',
          where: {'`quest`': creatureQuestEnder.quest},
        ),
      );
      try {
        await laconic.table('creature_questender').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in creature_questender');
        }
        rethrow;
      }
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
        throw DuplicateKeyException('duplicate key in creature_questender');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('creature_questender record not found');
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
