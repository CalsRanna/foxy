// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gossip_menu_option_repository.dart';

mixin _GossipMenuOptionRepositoryMixin on RepositoryMixin {
  Future<void> destroyGossipMenuOption(GossipMenuOptionKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('gossip_menu_option'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<GossipMenuOptionEntity?> getGossipMenuOption(
    GossipMenuOptionKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('gossip_menu_option'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return GossipMenuOptionEntity.fromJson(results.first.toMap());
  }

  Future<void> storeGossipMenuOption(
    GossipMenuOptionEntity gossipMenuOption,
  ) async {
    await _beforeStore(gossipMenuOption);
    final json = prepareWriteJson(gossipMenuOption.toJson());
    try {
      await laconic.table('gossip_menu_option').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateGossipMenuOption(
    GossipMenuOptionKey originalKey,
    GossipMenuOptionEntity gossipMenuOption,
  ) async {
    await _beforeUpdate(originalKey, gossipMenuOption);
    final json = prepareWriteJson(gossipMenuOption.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('gossip_menu_option'),
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

  Future<void> _beforeDestroy(GossipMenuOptionKey key) async {}

  Future<void> _beforeStore(GossipMenuOptionEntity gossipMenuOption) async {}

  Future<void> _beforeUpdate(
    GossipMenuOptionKey originalKey,
    GossipMenuOptionEntity gossipMenuOption,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, GossipMenuOptionKey key) {
    var query = builder;
    query = query.where('`MenuID`', key.menuId);
    query = query.where('`OptionID`', key.optionId);
    return query;
  }
}
