// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbc_faction_repository.dart';

mixin _DbcFactionRepositoryMixin on RepositoryMixin {
  Future<void> destroyDbcFaction(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_faction'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<DbcFactionEntity?> getDbcFaction(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_faction'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return DbcFactionEntity.fromJson(results.first.toMap());
  }

  Future<void> updateDbcFaction(
    int originalKey,
    DbcFactionEntity faction,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_faction'),
        originalKey,
      ).update(faction.toJson());
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

final class DbcFactionFilter {
  final String id;
  final String name;

  const DbcFactionFilter({this.id = '', this.name = ''});

  factory DbcFactionFilter.fromJson(Map<String, dynamic> json) {
    return DbcFactionFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  DbcFactionFilter copyWith({String? id, String? name}) {
    return DbcFactionFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
