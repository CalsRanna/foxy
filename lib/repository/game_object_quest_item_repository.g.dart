// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_quest_item_repository.dart';

mixin _GameObjectQuestItemRepositoryMixin on RepositoryMixin {
  Future<GameObjectQuestItemKey> copyGameObjectQuestItem(
    GameObjectQuestItemKey key,
  ) async {
    final source = await getGameObjectQuestItem(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createGameObjectQuestItem(source.gameObjectEntry);
    final copied = source.copyWith(
      gameObjectEntry: blank.gameObjectEntry,
      idx: blank.idx,
    );
    await storeGameObjectQuestItem(copied);
    return GameObjectQuestItemKey.fromEntity(copied);
  }

  Future<int> countGameObjectQuestItems(int gameObjectEntry) async {
    return laconic
        .table('gameobject_questitem')
        .where('`GameObjectEntry`', gameObjectEntry)
        .count();
  }

  Future<GameObjectQuestItemEntity> createGameObjectQuestItem(
    int gameObjectEntry,
  ) async {
    return GameObjectQuestItemEntity(
      gameObjectEntry: gameObjectEntry,
      idx: await nextMaxPlusOne(
        'gameobject_questitem',
        '`Idx`',
        where: {'GameObjectEntry': gameObjectEntry},
      ),
    );
  }

  Future<void> destroyGameObjectQuestItem(GameObjectQuestItemKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('gameobject_questitem'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<GameObjectQuestItemEntity?> getGameObjectQuestItem(
    GameObjectQuestItemKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('gameobject_questitem'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectQuestItemEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefGameObjectQuestItemEntity>> getBriefGameObjectQuestItems(
    int gameObjectEntry, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('gameobject_questitem').select([
      '`GameObjectEntry`',
      '`Idx`',
      '`ItemId`',
      '`VerifiedBuild`',
    ]);
    builder = builder.where('`GameObjectEntry`', gameObjectEntry);
    builder = builder.orderBy('`GameObjectEntry`').orderBy('`Idx`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefGameObjectQuestItemEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeGameObjectQuestItem(
    GameObjectQuestItemEntity gameObjectQuestItem,
  ) async {
    await _beforeStore(gameObjectQuestItem);
    final json = prepareWriteJson(gameObjectQuestItem.toJson());
    try {
      await laconic.table('gameobject_questitem').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateGameObjectQuestItem(
    GameObjectQuestItemKey originalKey,
    GameObjectQuestItemEntity gameObjectQuestItem,
  ) async {
    await _beforeUpdate(originalKey, gameObjectQuestItem);
    final json = prepareWriteJson(gameObjectQuestItem.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('gameobject_questitem'),
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

  Future<void> _beforeDestroy(GameObjectQuestItemKey key) async {}

  Future<void> _beforeStore(
    GameObjectQuestItemEntity gameObjectQuestItem,
  ) async {}

  Future<void> _beforeUpdate(
    GameObjectQuestItemKey originalKey,
    GameObjectQuestItemEntity gameObjectQuestItem,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, GameObjectQuestItemKey key) {
    var query = builder;
    query = query.where('`GameObjectEntry`', key.gameObjectEntry);
    query = query.where('`Idx`', key.idx);
    return query;
  }
}
