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

  Future<void> storeItemDisplayInfo(
    ItemDisplayInfoEntity itemDisplayInfo,
  ) async {
    if (itemDisplayInfo.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(itemDisplayInfo);
    final json = _prepareWriteJson(itemDisplayInfo.toJson());
    try {
      await laconic.table('foxy.dbc_item_display_info').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateItemDisplayInfo(
    int originalKey,
    ItemDisplayInfoEntity itemDisplayInfo,
  ) async {
    await _beforeUpdate(originalKey, itemDisplayInfo);
    final json = _prepareWriteJson(itemDisplayInfo.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_item_display_info'),
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

  Future<void> _beforeStore(ItemDisplayInfoEntity itemDisplayInfo) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    ItemDisplayInfoEntity itemDisplayInfo,
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
