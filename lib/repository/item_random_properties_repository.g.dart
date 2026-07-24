// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_random_properties_repository.dart';

mixin _ItemRandomPropertiesRepositoryMixin on RepositoryMixin {
  Future<void> destroyItemRandomProperties(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_item_random_properties'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<ItemRandomPropertiesEntity?> getItemRandomProperties(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_item_random_properties'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ItemRandomPropertiesEntity.fromJson(results.first.toMap());
  }

  Future<void> storeItemRandomProperties(
    ItemRandomPropertiesEntity itemRandomProperties,
  ) async {
    if (itemRandomProperties.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(itemRandomProperties);
    final json = _prepareWriteJson(itemRandomProperties.toJson());
    try {
      await laconic.table('foxy.dbc_item_random_properties').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateItemRandomProperties(
    int originalKey,
    ItemRandomPropertiesEntity itemRandomProperties,
  ) async {
    await _beforeUpdate(originalKey, itemRandomProperties);
    final json = _prepareWriteJson(itemRandomProperties.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_item_random_properties'),
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

  Future<void> _beforeStore(
    ItemRandomPropertiesEntity itemRandomProperties,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    ItemRandomPropertiesEntity itemRandomProperties,
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

final class ItemRandomPropertiesFilter {
  final String id;
  final String name;

  const ItemRandomPropertiesFilter({this.id = '', this.name = ''});

  factory ItemRandomPropertiesFilter.fromJson(Map<String, dynamic> json) {
    return ItemRandomPropertiesFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ItemRandomPropertiesFilter copyWith({String? id, String? name}) {
    return ItemRandomPropertiesFilter(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
