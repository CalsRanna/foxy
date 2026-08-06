// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbc_faction_repository.dart';

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

mixin _DbcFactionRepositoryMixin on RepositoryMixin, DbcLocaleRepositoryMixin {
  Future<void> destroyDbcFaction(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_faction'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_faction record not found');
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

  Future<List<DbcLocaleFieldValue>> getDbcFactionLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveDbcFactionLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeDbcFaction(DbcFactionEntity dbcFaction) async {
    if (dbcFaction.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(dbcFaction);
    final json = prepareWriteJson(dbcFaction.toJson());
    try {
      await laconic.table('foxy.dbc_faction').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = dbcFaction.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_faction', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_faction').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_faction');
        }
        rethrow;
      }
    }
  }

  Future<void> updateDbcFaction(
    int originalKey,
    DbcFactionEntity dbcFaction,
  ) async {
    await _beforeUpdate(originalKey, dbcFaction);
    final json = prepareWriteJson(dbcFaction.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_faction'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_faction');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_faction record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(DbcFactionEntity dbcFaction) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    DbcFactionEntity dbcFaction,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
