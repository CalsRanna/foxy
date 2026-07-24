// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_table_repository.dart';

mixin _AreaTableRepositoryMixin on RepositoryMixin {
  Future<void> destroyAreaTable(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_area_table'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<AreaTableEntity?> getAreaTable(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_area_table'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return AreaTableEntity.fromJson(results.first.toMap());
  }

  Future<void> storeAreaTable(AreaTableEntity areaTable) async {
    if (areaTable.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(areaTable);
    final json = _prepareWriteJson(areaTable.toJson());
    try {
      await laconic.table('foxy.dbc_area_table').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateAreaTable(
    int originalKey,
    AreaTableEntity areaTable,
  ) async {
    await _beforeUpdate(originalKey, areaTable);
    final json = _prepareWriteJson(areaTable.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_area_table'),
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

  Future<void> _beforeStore(AreaTableEntity areaTable) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    AreaTableEntity areaTable,
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

final class AreaTableFilter {
  final String id;
  final String name;

  const AreaTableFilter({this.id = '', this.name = ''});

  factory AreaTableFilter.fromJson(Map<String, dynamic> json) {
    return AreaTableFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  AreaTableFilter copyWith({String? id, String? name}) {
    return AreaTableFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
