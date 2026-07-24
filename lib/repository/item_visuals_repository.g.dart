// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_visuals_repository.dart';

mixin _ItemVisualsRepositoryMixin on RepositoryMixin {
  Future<void> destroyItemVisuals(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_item_visuals'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<ItemVisualsEntity?> getItemVisuals(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_item_visuals'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ItemVisualsEntity.fromJson(results.first.toMap());
  }

  Future<void> storeItemVisuals(ItemVisualsEntity itemVisuals) async {
    if (itemVisuals.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(itemVisuals);
    final json = _prepareWriteJson(itemVisuals.toJson());
    try {
      await laconic.table('foxy.dbc_item_visuals').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateItemVisuals(
    int originalKey,
    ItemVisualsEntity itemVisuals,
  ) async {
    await _beforeUpdate(originalKey, itemVisuals);
    final json = _prepareWriteJson(itemVisuals.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_item_visuals'),
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

  Future<void> _beforeStore(ItemVisualsEntity itemVisuals) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    ItemVisualsEntity itemVisuals,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

final class ItemVisualsFilter {
  final String id;

  const ItemVisualsFilter({this.id = ''});

  factory ItemVisualsFilter.fromJson(Map<String, dynamic> json) {
    return ItemVisualsFilter(id: json['id']?.toString() ?? '');
  }

  ItemVisualsFilter copyWith({String? id}) {
    return ItemVisualsFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
