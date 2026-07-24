// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_quest_starter_repository.dart';

mixin _GameObjectQuestStarterRepositoryMixin on RepositoryMixin {
  Future<void> destroyGameObjectQuestStarter(
    GameObjectQuestStarterKey key,
  ) async {
    final deletedRows = await _whereKey(
      laconic.table('gameobject_queststarter'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
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

  Future<void> storeGameObjectQuestStarter(
    GameObjectQuestStarterEntity gameObjectQuestStarter,
  ) async {
    await _beforeStore(gameObjectQuestStarter);
    final json = _prepareWriteJson(gameObjectQuestStarter.toJson());
    try {
      await laconic.table('gameobject_queststarter').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateGameObjectQuestStarter(
    GameObjectQuestStarterKey originalKey,
    GameObjectQuestStarterEntity gameObjectQuestStarter,
  ) async {
    await _beforeUpdate(originalKey, gameObjectQuestStarter);
    final json = _prepareWriteJson(gameObjectQuestStarter.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('gameobject_queststarter'),
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
    GameObjectQuestStarterEntity gameObjectQuestStarter,
  ) async {}

  Future<void> _beforeUpdate(
    GameObjectQuestStarterKey originalKey,
    GameObjectQuestStarterEntity gameObjectQuestStarter,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, GameObjectQuestStarterKey key) {
    var query = builder;
    query = query.where('id', key.id);
    query = query.where('quest', key.quest);
    return query;
  }
}
