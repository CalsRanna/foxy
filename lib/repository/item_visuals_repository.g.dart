// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_visuals_repository.dart';

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

mixin _ItemVisualsRepositoryMixin on RepositoryMixin {
  Future<void> destroyItemVisuals(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_item_visuals'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_item_visuals record not found');
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
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(itemVisuals);
    final json = prepareWriteJson(itemVisuals.toJson());
    try {
      await laconic.table('foxy.dbc_item_visuals').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_item_visuals');
      }
      rethrow;
    }
  }

  Future<void> updateItemVisuals(
    int originalKey,
    ItemVisualsEntity itemVisuals,
  ) async {
    await _beforeUpdate(originalKey, itemVisuals);
    final json = prepareWriteJson(itemVisuals.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_item_visuals'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_item_visuals');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_item_visuals record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(ItemVisualsEntity itemVisuals) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    ItemVisualsEntity itemVisuals,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
