// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_quest_item_repository.dart';

mixin _GameObjectQuestItemRepositoryMixin on RepositoryMixin {
  Future<void> destroyGameObjectQuestItem(GameObjectQuestItemKey key) async {
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

  Future<void> storeGameObjectQuestItem(
    GameObjectQuestItemEntity gameObjectQuestItem,
  ) async {
    await _beforeStore(gameObjectQuestItem);
    final json = _prepareWriteJson(gameObjectQuestItem.toJson());
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
    final json = _prepareWriteJson(gameObjectQuestItem.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('gameobject_questitem'),
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
    GameObjectQuestItemEntity gameObjectQuestItem,
  ) async {}

  Future<void> _beforeUpdate(
    GameObjectQuestItemKey originalKey,
    GameObjectQuestItemEntity gameObjectQuestItem,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, GameObjectQuestItemKey key) {
    var query = builder;
    query = query.where('GameObjectEntry', key.gameObjectEntry);
    query = query.where('Idx', key.idx);
    return query;
  }
}
