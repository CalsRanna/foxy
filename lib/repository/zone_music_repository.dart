import 'package:foxy/entity/zone_music_entity.dart';
import 'package:foxy/entity/zone_music_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ZoneMusicRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_zone_music';

  Future<void> copyZoneMusic(int id) async {
    final source = await getZoneMusic(id);
    if (source == null) return;
    final json = source.toJson()..['ID'] = await _getNextId();
    await laconic.table(_table).insert([json]);
  }

  Future<int> countZoneMusics({ZoneMusicFilterEntity? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<ZoneMusicEntity> createZoneMusic() async =>
      ZoneMusicEntity(id: await _getNextId());

  Future<void> destroyZoneMusic(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefZoneMusicEntity>> getBriefZoneMusics({
    int page = 1,
    ZoneMusicFilterEntity? filter,
  }) async {
    final rows = await _applyFilter(
      laconic.table(_table).select(['ID', 'SetName', 'Sounds0', 'Sounds1']),
      filter,
    ).orderBy('ID').limit(kPageSize).offset((page - 1) * kPageSize).get();
    return rows
        .map((row) => BriefZoneMusicEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<ZoneMusicEntity?> getZoneMusic(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    return rows.isEmpty ? null : ZoneMusicEntity.fromJson(rows.first.toMap());
  }

  Future<List<ZoneMusicEntity>> getZoneMusics() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => ZoneMusicEntity.fromJson(row.toMap())).toList();
  }

  Future<void> saveZoneMusic(ZoneMusicEntity entity) async {
    if (await getZoneMusic(entity.id) == null) {
      await storeZoneMusic(entity);
    } else {
      await updateZoneMusic(entity);
    }
  }

  Future<int> storeZoneMusic(ZoneMusicEntity entity) async {
    final json = entity.toJson();
    final id = entity.id > 0 ? entity.id : await _getNextId();
    json['ID'] = id;
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateZoneMusic(ZoneMusicEntity entity) async {
    final json = entity.toJson()..remove('ID');
    await laconic.table(_table).where('ID', entity.id).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ZoneMusicFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'SetName',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  Future<int> _getNextId() => nextMaxPlusOne(_table, 'ID');
}
