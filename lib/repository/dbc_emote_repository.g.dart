// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbc_emote_repository.dart';

mixin _DbcEmoteRepositoryMixin on RepositoryMixin {
  Future<void> destroyDbcEmote(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_emotes'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
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

  Future<void> storeDbcEmote(DbcEmoteEntity dbcEmote) async {
    if (dbcEmote.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(dbcEmote);
    final json = _prepareWriteJson(dbcEmote.toJson());
    try {
      await laconic.table('foxy.dbc_emotes').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateDbcEmote(int originalKey, DbcEmoteEntity dbcEmote) async {
    await _beforeUpdate(originalKey, dbcEmote);
    final json = _prepareWriteJson(dbcEmote.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_emotes'),
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

  Future<void> _beforeStore(DbcEmoteEntity dbcEmote) async {}

  Future<void> _beforeUpdate(int originalKey, DbcEmoteEntity dbcEmote) async {}

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
