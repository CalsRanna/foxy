// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_extended_cost_repository.dart';

mixin _ItemExtendedCostRepositoryMixin on RepositoryMixin {
  Future<void> destroyItemExtendedCost(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_item_extended_cost'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<ItemExtendedCostEntity?> getItemExtendedCost(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_item_extended_cost'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ItemExtendedCostEntity.fromJson(results.first.toMap());
  }

  Future<void> storeItemExtendedCost(
    ItemExtendedCostEntity itemExtendedCost,
  ) async {
    if (itemExtendedCost.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(itemExtendedCost);
    final json = _prepareWriteJson(itemExtendedCost.toJson());
    try {
      await laconic.table('foxy.dbc_item_extended_cost').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateItemExtendedCost(
    int originalKey,
    ItemExtendedCostEntity itemExtendedCost,
  ) async {
    await _beforeUpdate(originalKey, itemExtendedCost);
    final json = _prepareWriteJson(itemExtendedCost.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_item_extended_cost'),
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

  Future<void> _beforeStore(ItemExtendedCostEntity itemExtendedCost) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    ItemExtendedCostEntity itemExtendedCost,
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

final class ItemExtendedCostFilter {
  final String id;

  const ItemExtendedCostFilter({this.id = ''});

  factory ItemExtendedCostFilter.fromJson(Map<String, dynamic> json) {
    return ItemExtendedCostFilter(id: json['id']?.toString() ?? '');
  }

  ItemExtendedCostFilter copyWith({String? id}) {
    return ItemExtendedCostFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
