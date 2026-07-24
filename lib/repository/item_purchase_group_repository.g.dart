// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_purchase_group_repository.dart';

mixin _ItemPurchaseGroupRepositoryMixin on RepositoryMixin {
  Future<void> destroyItemPurchaseGroup(int key) async {
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

  Future<void> updateItemPurchaseGroup(
    int originalKey,
    ItemPurchaseGroupEntity group,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_item_purchase_group'),
        originalKey,
      ).update(group.toJson());
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
