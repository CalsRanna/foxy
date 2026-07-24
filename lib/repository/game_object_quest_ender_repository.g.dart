// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_quest_ender_repository.dart';

mixin _GameObjectQuestEnderRepositoryMixin on RepositoryMixin {
  Future<void> destroyGameObjectQuestEnder(GameObjectQuestEnderKey key) async {
    final deletedRows = await _whereKey(
      laconic.table('gameobject_questender'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
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

  Future<void> storeGameObjectQuestEnder(
    GameObjectQuestEnderEntity gameObjectQuestEnder,
  ) async {
    await _beforeStore(gameObjectQuestEnder);
    final json = _prepareWriteJson(gameObjectQuestEnder.toJson());
    try {
      await laconic.table('gameobject_questender').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateGameObjectQuestEnder(
    GameObjectQuestEnderKey originalKey,
    GameObjectQuestEnderEntity gameObjectQuestEnder,
  ) async {
    await _beforeUpdate(originalKey, gameObjectQuestEnder);
    final json = _prepareWriteJson(gameObjectQuestEnder.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('gameobject_questender'),
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
    GameObjectQuestEnderEntity gameObjectQuestEnder,
  ) async {}

  Future<void> _beforeUpdate(
    GameObjectQuestEnderKey originalKey,
    GameObjectQuestEnderEntity gameObjectQuestEnder,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, GameObjectQuestEnderKey key) {
    var query = builder;
    query = query.where('id', key.id);
    query = query.where('quest', key.quest);
    return query;
  }
}
