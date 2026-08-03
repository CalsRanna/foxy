// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gossip_menu_option_repository.dart';

mixin _GossipMenuOptionRepositoryMixin on RepositoryMixin {
  Future<GossipMenuOptionKey> copyGossipMenuOption(
    GossipMenuOptionKey key,
  ) async {
    final source = await getGossipMenuOption(key);
    if (source == null) {
      throw RecordNotFoundException('gossip_menu_option record not found');
    }
    final blank = await createGossipMenuOption(source.menuId);
    final copied = source.copyWith(
      menuId: blank.menuId,
      optionId: blank.optionId,
    );
    await storeGossipMenuOption(copied);
    return GossipMenuOptionKey.fromEntity(copied);
  }

  Future<int> countGossipMenuOptions(int menuId) async {
    return laconic
        .table('gossip_menu_option')
        .where('`MenuID`', menuId)
        .count();
  }

  Future<GossipMenuOptionEntity> createGossipMenuOption(int menuId) async {
    return GossipMenuOptionEntity(
      menuId: menuId,
      optionId: await nextMaxPlusOne(
        'gossip_menu_option',
        '`OptionID`',
        where: {'MenuID': menuId},
      ),
    );
  }

  Future<void> destroyGossipMenuOption(GossipMenuOptionKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('gossip_menu_option'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('gossip_menu_option record not found');
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

  Future<List<BriefGossipMenuOptionEntity>> getBriefGossipMenuOptions(
    int menuId, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('gossip_menu_option').select([
      '`MenuID`',
      '`OptionID`',
      '`OptionIcon`',
      '`OptionText`',
      '`OptionType`',
      '`OptionNpcFlag`',
      '`ActionMenuID`',
    ]);
    builder = builder.where('`MenuID`', menuId);
    builder = builder.orderBy('`MenuID`').orderBy('`OptionID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefGossipMenuOptionEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeGossipMenuOption(
    GossipMenuOptionEntity gossipMenuOption,
  ) async {
    await _beforeStore(gossipMenuOption);
    final json = prepareWriteJson(gossipMenuOption.toJson());
    try {
      await laconic.table('gossip_menu_option').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = gossipMenuOption.copyWith(
        optionId: await nextMaxPlusOne(
          'gossip_menu_option',
          '`OptionID`',
          where: {'`MenuID`': gossipMenuOption.menuId},
        ),
      );
      try {
        await laconic.table('gossip_menu_option').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in gossip_menu_option');
        }
        rethrow;
      }
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
        throw DuplicateKeyException('duplicate key in gossip_menu_option');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('gossip_menu_option record not found');
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
