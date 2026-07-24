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

  Future<void> updateAreaTable(int originalKey, AreaTableEntity area) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_area_table'),
        originalKey,
      ).update(area.toJson());
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
