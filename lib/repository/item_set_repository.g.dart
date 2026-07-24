// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_set_repository.dart';

mixin _ItemSetRepositoryMixin on RepositoryMixin {
  Future<void> destroyItemSet(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_item_set'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<ItemSetEntity?> getItemSet(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_item_set'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ItemSetEntity.fromJson(results.first.toMap());
  }

  Future<void> updateItemSet(int originalKey, ItemSetEntity itemSet) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_item_set'),
        originalKey,
      ).update(itemSet.toJson());
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

final class ItemSetFilter {
  final String id;
  final String name;

  const ItemSetFilter({this.id = '', this.name = ''});

  factory ItemSetFilter.fromJson(Map<String, dynamic> json) {
    return ItemSetFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ItemSetFilter copyWith({String? id, String? name}) {
    return ItemSetFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
