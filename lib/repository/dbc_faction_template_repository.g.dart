// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbc_faction_template_repository.dart';

final class DbcFactionTemplateFilter {
  final String id;
  final String faction;
  final String name;

  const DbcFactionTemplateFilter({
    this.id = '',
    this.faction = '',
    this.name = '',
  });

  factory DbcFactionTemplateFilter.fromJson(Map<String, dynamic> json) {
    return DbcFactionTemplateFilter(
      id: json['id']?.toString() ?? '',
      faction: json['faction']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  DbcFactionTemplateFilter copyWith({
    String? id,
    String? faction,
    String? name,
  }) {
    return DbcFactionTemplateFilter(
      id: id ?? this.id,
      faction: faction ?? this.faction,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'faction': faction, 'name': name};
  }
}

mixin _DbcFactionTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroyDbcFactionTemplate(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_faction_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<DbcFactionTemplateEntity?> getDbcFactionTemplate(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_faction_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return DbcFactionTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> storeDbcFactionTemplate(
    DbcFactionTemplateEntity dbcFactionTemplate,
  ) async {
    if (dbcFactionTemplate.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(dbcFactionTemplate);
    final json = prepareWriteJson(dbcFactionTemplate.toJson());
    try {
      await laconic.table('foxy.dbc_faction_template').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateDbcFactionTemplate(
    int originalKey,
    DbcFactionTemplateEntity dbcFactionTemplate,
  ) async {
    await _beforeUpdate(originalKey, dbcFactionTemplate);
    final json = prepareWriteJson(dbcFactionTemplate.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_faction_template'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    DbcFactionTemplateEntity dbcFactionTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    DbcFactionTemplateEntity dbcFactionTemplate,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
