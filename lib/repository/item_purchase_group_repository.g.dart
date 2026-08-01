// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_purchase_group_repository.dart';

final class ItemPurchaseGroupFilter {
  final String id;
  final String name;

  const ItemPurchaseGroupFilter({this.id = '', this.name = ''});

  factory ItemPurchaseGroupFilter.fromJson(Map<String, dynamic> json) {
    return ItemPurchaseGroupFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ItemPurchaseGroupFilter copyWith({String? id, String? name}) {
    return ItemPurchaseGroupFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _ItemPurchaseGroupRepositoryMixin on RepositoryMixin {
  Future<void> destroyItemPurchaseGroup(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_item_purchase_group'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<ItemPurchaseGroupEntity?> getItemPurchaseGroup(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_item_purchase_group'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ItemPurchaseGroupEntity.fromJson(results.first.toMap());
  }

  Future<void> storeItemPurchaseGroup(
    ItemPurchaseGroupEntity itemPurchaseGroup,
  ) async {
    if (itemPurchaseGroup.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(itemPurchaseGroup);
    final json = prepareWriteJson(itemPurchaseGroup.toJson());
    try {
      await laconic.table('foxy.dbc_item_purchase_group').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateItemPurchaseGroup(
    int originalKey,
    ItemPurchaseGroupEntity itemPurchaseGroup,
  ) async {
    await _beforeUpdate(originalKey, itemPurchaseGroup);
    final json = prepareWriteJson(itemPurchaseGroup.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_item_purchase_group'),
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

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(ItemPurchaseGroupEntity itemPurchaseGroup) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    ItemPurchaseGroupEntity itemPurchaseGroup,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
