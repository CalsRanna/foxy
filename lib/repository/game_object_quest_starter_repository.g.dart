// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_quest_starter_repository.dart';

mixin _GameObjectQuestStarterRepositoryMixin on RepositoryMixin {
  Future<GameObjectQuestStarterKey> copyGameObjectQuestStarter(
    GameObjectQuestStarterKey key,
  ) async {
    final source = await getGameObjectQuestStarter(key);
    if (source == null) {
      throw RecordNotFoundException('gameobject_queststarter record not found');
    }
    final blank = await createGameObjectQuestStarter(source.quest);
    final copied = source.copyWith(id: blank.id, quest: blank.quest);
    await storeGameObjectQuestStarter(copied);
    return GameObjectQuestStarterKey.fromEntity(copied);
  }

  Future<int> countGameObjectQuestStarters(int quest) async {
    return laconic
        .table('gameobject_queststarter')
        .where('`quest`', quest)
        .count();
  }

  Future<GameObjectQuestStarterEntity> createGameObjectQuestStarter(
    int quest,
  ) async {
    return GameObjectQuestStarterEntity(
      quest: quest,
      id: await nextMaxPlusOne(
        'gameobject_queststarter',
        '`id`',
        where: {'quest': quest},
      ),
    );
  }

  Future<void> destroyGameObjectQuestStarter(
    GameObjectQuestStarterKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('gameobject_queststarter'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('gameobject_queststarter record not found');
    }
  }

  Future<GameObjectQuestStarterEntity?> getGameObjectQuestStarter(
    GameObjectQuestStarterKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('gameobject_queststarter'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectQuestStarterEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefGameObjectQuestStarterEntity>>
  getBriefGameObjectQuestStarters(int quest, {int page = 1}) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('gameobject_queststarter').select([
      '`id`',
      '`quest`',
    ]);
    builder = builder.where('`quest`', quest);
    builder = builder.orderBy('`id`').orderBy('`quest`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefGameObjectQuestStarterEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeGameObjectQuestStarter(
    GameObjectQuestStarterEntity gameObjectQuestStarter,
  ) async {
    await _beforeStore(gameObjectQuestStarter);
    final json = prepareWriteJson(gameObjectQuestStarter.toJson());
    try {
      await laconic.table('gameobject_queststarter').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = gameObjectQuestStarter.copyWith(
        id: await nextMaxPlusOne(
          'gameobject_queststarter',
          '`id`',
          where: {'`quest`': gameObjectQuestStarter.quest},
        ),
      );
      try {
        await laconic.table('gameobject_queststarter').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in gameobject_queststarter',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updateGameObjectQuestStarter(
    GameObjectQuestStarterKey originalKey,
    GameObjectQuestStarterEntity gameObjectQuestStarter,
  ) async {
    await _beforeUpdate(originalKey, gameObjectQuestStarter);
    final json = prepareWriteJson(gameObjectQuestStarter.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('gameobject_queststarter'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in gameobject_queststarter');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('gameobject_queststarter record not found');
    }
  }

  Future<void> _beforeDestroy(GameObjectQuestStarterKey key) async {}

  Future<void> _beforeStore(
    GameObjectQuestStarterEntity gameObjectQuestStarter,
  ) async {}

  Future<void> _beforeUpdate(
    GameObjectQuestStarterKey originalKey,
    GameObjectQuestStarterEntity gameObjectQuestStarter,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, GameObjectQuestStarterKey key) {
    var query = builder;
    query = query.where('`id`', key.id);
    query = query.where('`quest`', key.quest);
    return query;
  }
}
