// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_item_repository.dart';

mixin _PlayerCreateInfoItemRepositoryMixin on RepositoryMixin {
  Future<void> destroyPlayerCreateInfoItem(PlayerCreateInfoItemKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('playercreateinfo_item'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<PlayerCreateInfoItemEntity?> getPlayerCreateInfoItem(
    PlayerCreateInfoItemKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('playercreateinfo_item'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return PlayerCreateInfoItemEntity.fromJson(results.first.toMap());
  }

  Future<void> storePlayerCreateInfoItem(
    PlayerCreateInfoItemEntity playerCreateInfoItem,
  ) async {
    await _beforeStore(playerCreateInfoItem);
    final json = prepareWriteJson(playerCreateInfoItem.toJson());
    try {
      await laconic.table('playercreateinfo_item').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updatePlayerCreateInfoItem(
    PlayerCreateInfoItemKey originalKey,
    PlayerCreateInfoItemEntity playerCreateInfoItem,
  ) async {
    await _beforeUpdate(originalKey, playerCreateInfoItem);
    final json = prepareWriteJson(playerCreateInfoItem.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('playercreateinfo_item'),
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

  Future<void> _beforeDestroy(PlayerCreateInfoItemKey key) async {}

  Future<void> _beforeStore(
    PlayerCreateInfoItemEntity playerCreateInfoItem,
  ) async {}

  Future<void> _beforeUpdate(
    PlayerCreateInfoItemKey originalKey,
    PlayerCreateInfoItemEntity playerCreateInfoItem,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, PlayerCreateInfoItemKey key) {
    var query = builder;
    query = query.where('`race`', key.race);
    query = query.where('`class`', key.class_);
    query = query.where('`itemid`', key.itemId);
    return query;
  }
}
