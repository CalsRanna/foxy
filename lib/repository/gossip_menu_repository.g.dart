// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gossip_menu_repository.dart';

mixin _GossipMenuRepositoryMixin on RepositoryMixin {
  Future<void> destroyGossipMenu(GossipMenuKey key) async {
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

  Future<void> storeGossipMenu(GossipMenuEntity gossipMenu) async {
    await _beforeStore(gossipMenu);
    final json = _prepareWriteJson(gossipMenu.toJson());
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
    final json = _prepareWriteJson(gossipMenu.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('gossip_menu'),
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

  Future<void> _beforeStore(GossipMenuEntity gossipMenu) async {}

  Future<void> _beforeUpdate(
    GossipMenuKey originalKey,
    GossipMenuEntity gossipMenu,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, GossipMenuKey key) {
    var query = builder;
    query = query.where('MenuID', key.menuId);
    query = query.where('TextID', key.textId);
    return query;
  }
}

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
