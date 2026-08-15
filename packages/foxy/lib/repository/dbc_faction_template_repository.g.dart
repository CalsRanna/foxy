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
  String get _table => 'foxy.dbc_faction_template';

  Future<void> destroyDbcFactionTemplate(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_faction_template record not found',
      );
    }
  }

  Future<DbcFactionTemplateEntity?> getDbcFactionTemplate(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return DbcFactionTemplateEntity.fromJson(results.first.toMap());
  }

  Future<int> storeDbcFactionTemplate(
    DbcFactionTemplateEntity dbcFactionTemplate,
  ) async {
    if (dbcFactionTemplate.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(dbcFactionTemplate);
    final json = prepareWriteJson(dbcFactionTemplate.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = dbcFactionTemplate.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_faction_template',
          );
        }
        rethrow;
      }
    }
    return dbcFactionTemplate.id;
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
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_faction_template',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_faction_template record not found',
      );
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
