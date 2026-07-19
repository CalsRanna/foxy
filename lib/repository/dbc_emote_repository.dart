import 'package:foxy/entity/brief_dbc_emote_entity.dart';
import 'package:foxy/entity/dbc_emote_entity.dart';
import 'package:foxy/entity/dbc_emote_filter_entity.dart';
import 'package:foxy/entity/dbc_emote_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class DbcEmoteRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_emotes';

  Future<DbcEmoteKey> copyDbcEmote(DbcEmoteKey key) async {
    final source = await getDbcEmote(key);
    if (source == null) {
      throw StateError('原表情不存在，可能已被其他操作修改或删除');
    }
    final copied = DbcEmoteEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeDbcEmote(copied);
    return DbcEmoteKey.fromEntity(copied);
  }

  Future<int> countDbcEmotes({DbcEmoteFilterEntity? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<DbcEmoteEntity> createDbcEmote() async =>
      DbcEmoteEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<void> destroyDbcEmote(DbcEmoteKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原表情不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefDbcEmoteEntity>> getBriefDbcEmotes({
    int page = 1,
    DbcEmoteFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table).select([
      'ID',
      'EmoteSlashCommand',
      'AnimID',
    ]);
    builder = _applyFilter(builder, filter).orderBy('ID');
    final rows = await builder
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows
        .map((row) => BriefDbcEmoteEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<DbcEmoteEntity?> getDbcEmote(DbcEmoteKey key) async {
    final rows = await _whereKey(laconic.table(_table), key).limit(1).get();
    return rows.isEmpty ? null : DbcEmoteEntity.fromJson(rows.first.toMap());
  }

  Future<List<DbcEmoteEntity>> getDbcEmotes() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => DbcEmoteEntity.fromJson(row.toMap())).toList();
  }

  Future<void> storeDbcEmote(DbcEmoteEntity emote) async {
    if (emote.id <= 0) {
      throw StateError('表情 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([emote.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('表情 ${emote.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateDbcEmote(
    DbcEmoteKey originalKey,
    DbcEmoteEntity emote,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(emote.toJson());
      if (matchedRows == 0) {
        throw StateError('原表情不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的表情 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    DbcEmoteFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.command.isNotEmpty) {
      builder = builder.where(
        'EmoteSlashCommand',
        '%${filter.command}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, DbcEmoteKey key) {
    return builder.where('ID', key.id);
  }
}
