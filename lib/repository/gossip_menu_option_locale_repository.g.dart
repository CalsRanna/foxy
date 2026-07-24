// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gossip_menu_option_locale_repository.dart';

mixin _GossipMenuOptionLocaleRepositoryMixin on RepositoryMixin {
  Future<void> destroyGossipMenuOptionLocale(
    GossipMenuOptionLocaleKey key,
  ) async {
    final deletedRows = await _whereKey(
      laconic.table('gossip_menu_option_locale'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<GossipMenuOptionLocaleEntity?> getGossipMenuOptionLocale(
    GossipMenuOptionLocaleKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('gossip_menu_option_locale'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return GossipMenuOptionLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storeGossipMenuOptionLocale(
    GossipMenuOptionLocaleEntity gossipMenuOptionLocale,
  ) async {
    await _beforeStore(gossipMenuOptionLocale);
    final json = _prepareWriteJson(gossipMenuOptionLocale.toJson());
    try {
      await laconic.table('gossip_menu_option_locale').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateGossipMenuOptionLocale(
    GossipMenuOptionLocaleKey originalKey,
    GossipMenuOptionLocaleEntity gossipMenuOptionLocale,
  ) async {
    await _beforeUpdate(originalKey, gossipMenuOptionLocale);
    final json = _prepareWriteJson(gossipMenuOptionLocale.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('gossip_menu_option_locale'),
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
    GossipMenuOptionLocaleEntity gossipMenuOptionLocale,
  ) async {}

  Future<void> _beforeUpdate(
    GossipMenuOptionLocaleKey originalKey,
    GossipMenuOptionLocaleEntity gossipMenuOptionLocale,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    return {
      for (final entry in json.entries)
        if (const {'index', 'rank'}.contains(entry.key.toLowerCase()))
          '`${entry.key}`': entry.value
        else
          entry.key: entry.value,
    };
  }

  QueryBuilder _whereKey(QueryBuilder builder, GossipMenuOptionLocaleKey key) {
    var query = builder;
    query = query.where('MenuID', key.menuId);
    query = query.where('OptionID', key.optionId);
    query = query.where('Locale', key.locale);
    return query;
  }
}
