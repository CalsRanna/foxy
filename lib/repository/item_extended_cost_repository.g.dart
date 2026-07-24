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

  Future<void> updateItemExtendedCost(
    int originalKey,
    ItemExtendedCostEntity itemExtendedCost,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_item_extended_cost'),
        originalKey,
      ).update(itemExtendedCost.toJson());
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
