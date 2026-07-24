// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_random_suffix_repository.dart';

mixin _ItemRandomSuffixRepositoryMixin on RepositoryMixin {
  Future<void> destroyItemRandomSuffix(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_item_random_suffix'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<ItemRandomSuffixEntity?> getItemRandomSuffix(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_item_random_suffix'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ItemRandomSuffixEntity.fromJson(results.first.toMap());
  }

  Future<void> storeItemRandomSuffix(
    ItemRandomSuffixEntity itemRandomSuffix,
  ) async {
    if (itemRandomSuffix.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(itemRandomSuffix);
    final json = _prepareWriteJson(itemRandomSuffix.toJson());
    try {
      await laconic.table('foxy.dbc_item_random_suffix').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateItemRandomSuffix(
    int originalKey,
    ItemRandomSuffixEntity itemRandomSuffix,
  ) async {
    await _beforeUpdate(originalKey, itemRandomSuffix);
    final json = _prepareWriteJson(itemRandomSuffix.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_item_random_suffix'),
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

  Future<void> _beforeStore(ItemRandomSuffixEntity itemRandomSuffix) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    ItemRandomSuffixEntity itemRandomSuffix,
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

final class ItemRandomSuffixFilter {
  final String id;
  final String name;

  const ItemRandomSuffixFilter({this.id = '', this.name = ''});

  factory ItemRandomSuffixFilter.fromJson(Map<String, dynamic> json) {
    return ItemRandomSuffixFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ItemRandomSuffixFilter copyWith({String? id, String? name}) {
    return ItemRandomSuffixFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
