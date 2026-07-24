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

  Future<void> updateGossipMenu(
    GossipMenuKey originalKey,
    GossipMenuEntity menu,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('gossip_menu'),
        originalKey,
      ).update(menu.toJson());
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
