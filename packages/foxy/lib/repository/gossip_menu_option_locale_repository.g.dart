// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gossip_menu_option_locale_repository.dart';

mixin _GossipMenuOptionLocaleRepositoryMixin on RepositoryMixin {
  String get _table => 'gossip_menu_option_locale';

  Future<void> destroyGossipMenuOptionLocale(
    GossipMenuOptionLocaleKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'gossip_menu_option_locale record not found',
      );
    }
  }

  Future<GossipMenuOptionLocaleEntity?> getGossipMenuOptionLocale(
    GossipMenuOptionLocaleKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return GossipMenuOptionLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storeGossipMenuOptionLocale(
    GossipMenuOptionLocaleEntity gossipMenuOptionLocale,
  ) async {
    await _beforeStore(gossipMenuOptionLocale);
    final json = prepareWriteJson(gossipMenuOptionLocale.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      throw DuplicateKeyException('duplicate key in gossip_menu_option_locale');
    }
  }

  Future<void> updateGossipMenuOptionLocale(
    GossipMenuOptionLocaleKey originalKey,
    GossipMenuOptionLocaleEntity gossipMenuOptionLocale,
  ) async {
    await _beforeUpdate(originalKey, gossipMenuOptionLocale);
    final json = prepareWriteJson(gossipMenuOptionLocale.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in gossip_menu_option_locale',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'gossip_menu_option_locale record not found',
      );
    }
  }

  Future<void> _beforeDestroy(GossipMenuOptionLocaleKey key) async {}

  Future<void> _beforeStore(
    GossipMenuOptionLocaleEntity gossipMenuOptionLocale,
  ) async {}

  Future<void> _beforeUpdate(
    GossipMenuOptionLocaleKey originalKey,
    GossipMenuOptionLocaleEntity gossipMenuOptionLocale,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, GossipMenuOptionLocaleKey key) {
    var query = builder;
    query = query.where('`MenuID`', key.menuId);
    query = query.where('`OptionID`', key.optionId);
    query = query.where('`Locale`', key.locale);
    return query;
  }
}
