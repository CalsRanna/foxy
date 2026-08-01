// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gossip_menu_repository.dart';

final class GossipMenuFilter {
  final String menuId;
  final String text;

  const GossipMenuFilter({this.menuId = '', this.text = ''});

  factory GossipMenuFilter.fromJson(Map<String, dynamic> json) {
    return GossipMenuFilter(
      menuId: json['menuId']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
    );
  }

  GossipMenuFilter copyWith({String? menuId, String? text}) {
    return GossipMenuFilter(
      menuId: menuId ?? this.menuId,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toJson() {
    return {'menuId': menuId, 'text': text};
  }
}

mixin _GossipMenuRepositoryMixin on RepositoryMixin {
  Future<GossipMenuKey> copyGossipMenu(GossipMenuKey key) async {
    final source = await getGossipMenu(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createGossipMenu();
    final copied = source.copyWith(menuId: blank.menuId, textId: blank.textId);
    await storeGossipMenu(copied);
    return GossipMenuKey.fromEntity(copied);
  }

  Future<int> countGossipMenus({GossipMenuFilter? filter}) async {
    return _applyFilter(laconic.table('gossip_menu'), filter).count();
  }

  Future<GossipMenuEntity> createGossipMenu() async {
    return GossipMenuEntity(
      menuId: await nextMaxPlusOne('gossip_menu', '`MenuID`'),
      textId: await nextMaxPlusOne('gossip_menu', '`TextID`'),
    );
  }

  Future<void> destroyGossipMenu(GossipMenuKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('gossip_menu'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<GossipMenuEntity?> getGossipMenu(GossipMenuKey key) async {
    final results = await _whereKey(
      laconic.table('gossip_menu'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return GossipMenuEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefGossipMenuEntity>> getBriefGossipMenus({
    int page = 1,
    GossipMenuFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('gossip_menu').select(['`MenuID`', '`TextID`']);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`MenuID`').orderBy('`TextID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefGossipMenuEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<GossipMenuEntity>> getGossipMenus() async {
    var builder = laconic
        .table('gossip_menu')
        .orderBy('`MenuID`')
        .orderBy('`TextID`');
    final results = await builder.get();
    return results.map((e) => GossipMenuEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeGossipMenu(GossipMenuEntity gossipMenu) async {
    await _beforeStore(gossipMenu);
    final json = prepareWriteJson(gossipMenu.toJson());
    try {
      await laconic.table('gossip_menu').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateGossipMenu(
    GossipMenuKey originalKey,
    GossipMenuEntity gossipMenu,
  ) async {
    await _beforeUpdate(originalKey, gossipMenu);
    final json = prepareWriteJson(gossipMenu.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('gossip_menu'),
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

  QueryBuilder _applyFilter(QueryBuilder builder, GossipMenuFilter? filter) {
    if (filter == null) return builder;
    if (filter.menuId.isNotEmpty) {
      builder = builder.where('`MenuID`', filter.menuId);
    }
    if (filter.text.isNotEmpty) {
      builder = builder.where('`nt.text0_0`', filter.text);
    }
    return builder;
  }

  Future<void> _beforeDestroy(GossipMenuKey key) async {}

  Future<void> _beforeStore(GossipMenuEntity gossipMenu) async {}

  Future<void> _beforeUpdate(
    GossipMenuKey originalKey,
    GossipMenuEntity gossipMenu,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, GossipMenuKey key) {
    var query = builder;
    query = query.where('`MenuID`', key.menuId);
    query = query.where('`TextID`', key.textId);
    return query;
  }
}
