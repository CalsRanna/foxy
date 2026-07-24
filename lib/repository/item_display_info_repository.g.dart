// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_display_info_repository.dart';

mixin _ItemDisplayInfoRepositoryMixin on RepositoryMixin {
  Future<void> destroyItemDisplayInfo(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_item_display_info'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<ItemDisplayInfoEntity?> getItemDisplayInfo(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_item_display_info'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ItemDisplayInfoEntity.fromJson(results.first.toMap());
  }

  Future<void> updateItemDisplayInfo(
    int originalKey,
    ItemDisplayInfoEntity info,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_item_display_info'),
        originalKey,
      ).update(info.toJson());
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

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

final class ItemDisplayInfoFilter {
  final String id;
  final String name;

  const ItemDisplayInfoFilter({this.id = '', this.name = ''});

  factory ItemDisplayInfoFilter.fromJson(Map<String, dynamic> json) {
    return ItemDisplayInfoFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ItemDisplayInfoFilter copyWith({String? id, String? name}) {
    return ItemDisplayInfoFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
