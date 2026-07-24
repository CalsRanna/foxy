// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_action_repository.dart';

mixin _PlayerCreateInfoActionRepositoryMixin on RepositoryMixin {
  Future<void> destroyPlayerCreateInfoAction(
    PlayerCreateInfoActionKey key,
  ) async {
    final deletedRows = await _whereKey(
      laconic.table('playercreateinfo_action'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<PlayerCreateInfoActionEntity?> getPlayerCreateInfoAction(
    PlayerCreateInfoActionKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('playercreateinfo_action'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return PlayerCreateInfoActionEntity.fromJson(results.first.toMap());
  }

  Future<void> storePlayerCreateInfoAction(
    PlayerCreateInfoActionEntity playerCreateInfoAction,
  ) async {
    await _beforeStore(playerCreateInfoAction);
    final json = _prepareWriteJson(playerCreateInfoAction.toJson());
    try {
      await laconic.table('playercreateinfo_action').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updatePlayerCreateInfoAction(
    PlayerCreateInfoActionKey originalKey,
    PlayerCreateInfoActionEntity playerCreateInfoAction,
  ) async {
    await _beforeUpdate(originalKey, playerCreateInfoAction);
    final json = _prepareWriteJson(playerCreateInfoAction.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('playercreateinfo_action'),
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
    PlayerCreateInfoActionEntity playerCreateInfoAction,
  ) async {}

  Future<void> _beforeUpdate(
    PlayerCreateInfoActionKey originalKey,
    PlayerCreateInfoActionEntity playerCreateInfoAction,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, PlayerCreateInfoActionKey key) {
    var query = builder;
    query = query.where('race', key.race);
    query = query.where('class', key.class_);
    query = query.where('button', key.button);
    return query;
  }
}
