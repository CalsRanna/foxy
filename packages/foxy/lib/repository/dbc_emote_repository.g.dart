// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbc_emote_repository.dart';

final class DbcEmoteFilter {
  final String id;
  final String command;

  const DbcEmoteFilter({this.id = '', this.command = ''});

  factory DbcEmoteFilter.fromJson(Map<String, dynamic> json) {
    return DbcEmoteFilter(
      id: json['id']?.toString() ?? '',
      command: json['command']?.toString() ?? '',
    );
  }

  DbcEmoteFilter copyWith({String? id, String? command}) {
    return DbcEmoteFilter(id: id ?? this.id, command: command ?? this.command);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'command': command};
  }
}

mixin _DbcEmoteRepositoryMixin on RepositoryMixin {
  Future<void> destroyDbcEmote(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_emotes'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_emotes record not found');
    }
  }

  Future<DbcEmoteEntity?> getDbcEmote(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_emotes'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return DbcEmoteEntity.fromJson(results.first.toMap());
  }

  Future<int> storeDbcEmote(DbcEmoteEntity dbcEmote) async {
    if (dbcEmote.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(dbcEmote);
    final json = prepareWriteJson(dbcEmote.toJson());
    try {
      await laconic.table('foxy.dbc_emotes').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = dbcEmote.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_emotes', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_emotes').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_emotes');
        }
        rethrow;
      }
    }
    return dbcEmote.id;
  }

  Future<void> updateDbcEmote(int originalKey, DbcEmoteEntity dbcEmote) async {
    await _beforeUpdate(originalKey, dbcEmote);
    final json = prepareWriteJson(dbcEmote.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_emotes'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_emotes');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_emotes record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(DbcEmoteEntity dbcEmote) async {}

  Future<void> _beforeUpdate(int originalKey, DbcEmoteEntity dbcEmote) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
