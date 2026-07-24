// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbc_item_repository.dart';

mixin _DbcItemRepositoryMixin on RepositoryMixin {
  Future<void> destroyDbcItem(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_item'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<DbcItemEntity?> getDbcItem(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_item'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return DbcItemEntity.fromJson(results.first.toMap());
  }

  Future<void> storeDbcItem(DbcItemEntity dbcItem) async {
    if (dbcItem.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(dbcItem);
    final json = _prepareWriteJson(dbcItem.toJson());
    try {
      await laconic.table('foxy.dbc_item').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateDbcItem(int originalKey, DbcItemEntity dbcItem) async {
    await _beforeUpdate(originalKey, dbcItem);
    final json = _prepareWriteJson(dbcItem.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_item'),
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

  Future<void> _beforeStore(DbcItemEntity dbcItem) async {}

  Future<void> _beforeUpdate(int originalKey, DbcItemEntity dbcItem) async {}

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

final class DbcItemFilter {
  final String id;
  final bool handEquippableOnly;

  const DbcItemFilter({this.id = '', this.handEquippableOnly = false});

  factory DbcItemFilter.fromJson(Map<String, dynamic> json) {
    return DbcItemFilter(
      id: json['id']?.toString() ?? '',
      handEquippableOnly: json['handEquippableOnly'] as bool? ?? false,
    );
  }

  DbcItemFilter copyWith({String? id, bool? handEquippableOnly}) {
    return DbcItemFilter(
      id: id ?? this.id,
      handEquippableOnly: handEquippableOnly ?? this.handEquippableOnly,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'handEquippableOnly': handEquippableOnly};
  }
}
