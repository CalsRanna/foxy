import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/dbc_emote_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'dbc_emote_repository.g.dart';

@FoxyRepository(DbcEmoteEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('command')
class DbcEmoteRepository with RepositoryMixin, _DbcEmoteRepositoryMixin {
  static const _table = 'foxy.dbc_emotes';

  Future<int> copyDbcEmote(int key) async {
    final source = await getDbcEmote(key);
    if (source == null) {
      throw StateError('原表情不存在，可能已被其他操作修改或删除');
    }
    final copied = DbcEmoteEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeDbcEmote(copied);
    return copied.id;
  }

  Future<int> countDbcEmotes({DbcEmoteFilter? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<DbcEmoteEntity> createDbcEmote() async =>
      DbcEmoteEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<List<BriefDbcEmoteEntity>> getBriefDbcEmotes({
    int page = 1,
    DbcEmoteFilter? filter,
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

  QueryBuilder _applyFilter(QueryBuilder builder, DbcEmoteFilter? filter) {
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
}
