import 'package:foxy/entity/dbc_emote_entity.dart';
import 'package:foxy/entity/dbc_emote_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class DbcEmoteRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_emotes';

  Future<void> copyDbcEmote(int id) async {
    final source = await getDbcEmote(id);
    if (source == null) return;
    final json = source.toJson()..['ID'] = await nextMaxPlusOne(_table, 'ID');
    await laconic.table(_table).insert([json]);
  }

  Future<int> countDbcEmotes({DbcEmoteFilterEntity? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<DbcEmoteEntity> createDbcEmote() async =>
      DbcEmoteEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<void> destroyDbcEmote(int id) async {
    await laconic.table(_table).where('ID', id).delete();
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

  Future<DbcEmoteEntity?> getDbcEmote(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    return rows.isEmpty ? null : DbcEmoteEntity.fromJson(rows.first.toMap());
  }

  Future<List<DbcEmoteEntity>> getDbcEmotes() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => DbcEmoteEntity.fromJson(row.toMap())).toList();
  }

  Future<void> saveDbcEmote(DbcEmoteEntity emote) async {
    if (await getDbcEmote(emote.id) == null) {
      await storeDbcEmote(emote);
    } else {
      await updateDbcEmote(emote);
    }
  }

  Future<int> storeDbcEmote(DbcEmoteEntity emote) async {
    final json = emote.toJson();
    final id = emote.id > 0 ? emote.id : await nextMaxPlusOne(_table, 'ID');
    json['ID'] = id;
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateDbcEmote(DbcEmoteEntity emote) async {
    final json = emote.toJson()..remove('ID');
    await laconic.table(_table).where('ID', emote.id).update(json);
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
}
