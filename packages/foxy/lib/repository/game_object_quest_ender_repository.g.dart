// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_quest_ender_repository.dart';

mixin _GameObjectQuestEnderRepositoryMixin on RepositoryMixin {
  Future<GameObjectQuestEnderKey> copyGameObjectQuestEnder(
    GameObjectQuestEnderKey key,
  ) async {
    final source = await getGameObjectQuestEnder(key);
    if (source == null) {
      throw RecordNotFoundException('gameobject_questender record not found');
    }
    final blank = await createGameObjectQuestEnder(source.quest);
    final copied = source.copyWith(id: blank.id, quest: blank.quest);
    await storeGameObjectQuestEnder(copied);
    return GameObjectQuestEnderKey.fromEntity(copied);
  }

  Future<int> countGameObjectQuestEnders(int quest) async {
    return laconic
        .table('gameobject_questender')
        .where('`quest`', quest)
        .count();
  }

  Future<GameObjectQuestEnderEntity> createGameObjectQuestEnder(
    int quest,
  ) async {
    return GameObjectQuestEnderEntity(
      quest: quest,
      id: await nextMaxPlusOne(
        'gameobject_questender',
        '`id`',
        where: {'`quest`': quest},
      ),
    );
  }

  Future<void> destroyGameObjectQuestEnder(GameObjectQuestEnderKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('gameobject_questender'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('gameobject_questender record not found');
    }
  }

  Future<GameObjectQuestEnderEntity?> getGameObjectQuestEnder(
    GameObjectQuestEnderKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('gameobject_questender'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectQuestEnderEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefGameObjectQuestEnderEntity>> getBriefGameObjectQuestEnders(
    int quest, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('gameobject_questender').select([
      '`id`',
      '`quest`',
    ]);
    builder = builder.where('`quest`', quest);
    builder = builder.orderBy('`id`').orderBy('`quest`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefGameObjectQuestEnderEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeGameObjectQuestEnder(
    GameObjectQuestEnderEntity gameObjectQuestEnder,
  ) async {
    await _beforeStore(gameObjectQuestEnder);
    final json = prepareWriteJson(gameObjectQuestEnder.toJson());
    try {
      await laconic.table('gameobject_questender').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = gameObjectQuestEnder.copyWith(
        id: await nextMaxPlusOne(
          'gameobject_questender',
          '`id`',
          where: {'`quest`': gameObjectQuestEnder.quest},
        ),
      );
      try {
        await laconic.table('gameobject_questender').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in gameobject_questender');
        }
        rethrow;
      }
    }
  }

  Future<void> updateGameObjectQuestEnder(
    GameObjectQuestEnderKey originalKey,
    GameObjectQuestEnderEntity gameObjectQuestEnder,
  ) async {
    await _beforeUpdate(originalKey, gameObjectQuestEnder);
    final json = prepareWriteJson(gameObjectQuestEnder.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('gameobject_questender'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in gameobject_questender');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('gameobject_questender record not found');
    }
  }

  Future<void> _beforeDestroy(GameObjectQuestEnderKey key) async {}

  Future<void> _beforeStore(
    GameObjectQuestEnderEntity gameObjectQuestEnder,
  ) async {}

  Future<void> _beforeUpdate(
    GameObjectQuestEnderKey originalKey,
    GameObjectQuestEnderEntity gameObjectQuestEnder,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, GameObjectQuestEnderKey key) {
    var query = builder;
    query = query.where('`id`', key.id);
    query = query.where('`quest`', key.quest);
    return query;
  }
}
