import 'package:foxy/entity/zone_intro_music_entity.dart';
import 'package:foxy/entity/zone_intro_music_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ZoneIntroMusicRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_zone_intro_music_table';

  Future<List<BriefZoneIntroMusicEntity>> getBriefZoneIntroMusics({
    int page = 1,
    ZoneIntroMusicFilterEntity? filter,
  }) async {
    final rows = await _applyFilter(
      laconic.table(_table).select(['ID', 'Name', 'SoundID']),
      filter,
    ).orderBy('ID').limit(kPageSize).offset((page - 1) * kPageSize).get();
    return rows
        .map((row) => BriefZoneIntroMusicEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<ZoneIntroMusicEntity>> getZoneIntroMusics() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => ZoneIntroMusicEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<int> countZoneIntroMusics({ZoneIntroMusicFilterEntity? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<ZoneIntroMusicEntity?> getZoneIntroMusic(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    return rows.isEmpty
        ? null
        : ZoneIntroMusicEntity.fromJson(rows.first.toMap());
  }

  Future<ZoneIntroMusicEntity> createZoneIntroMusic() async =>
      ZoneIntroMusicEntity(id: await _getNextId());

  Future<int> storeZoneIntroMusic(ZoneIntroMusicEntity entity) async {
    final json = entity.toJson();
    final id = entity.id > 0 ? entity.id : await _getNextId();
    json['ID'] = id;
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateZoneIntroMusic(ZoneIntroMusicEntity entity) async {
    final json = entity.toJson()..remove('ID');
    await laconic.table(_table).where('ID', entity.id).update(json);
  }

  Future<void> destroyZoneIntroMusic(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyZoneIntroMusic(int id) async {
    final source = await getZoneIntroMusic(id);
    if (source == null) return;
    final json = source.toJson()..['ID'] = await _getNextId();
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveZoneIntroMusic(ZoneIntroMusicEntity entity) async {
    if (await getZoneIntroMusic(entity.id) == null) {
      await storeZoneIntroMusic(entity);
    } else {
      await updateZoneIntroMusic(entity);
    }
  }

  Future<int> _getNextId() => nextMaxPlusOne(_table, 'ID');

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ZoneIntroMusicFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.name.isNotEmpty) {
      builder = builder.where('Name', '%${filter.name}%', comparator: 'like');
    }
    return builder;
  }
}
