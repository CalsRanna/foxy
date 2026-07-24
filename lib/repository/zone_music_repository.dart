import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/zone_music_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'zone_music_repository.g.dart';

@FoxyRepository(ZoneMusicEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class ZoneMusicRepository with RepositoryMixin, _ZoneMusicRepositoryMixin {
  static const _table = 'foxy.dbc_zone_music';

  Future<int> copyZoneMusic(int key) async {
    final source = await getZoneMusic(key);
    if (source == null) {
      throw StateError('原区域音乐不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeZoneMusic(copied);
    return copied.id;
  }

  Future<int> countZoneMusics({ZoneMusicFilter? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<ZoneMusicEntity> createZoneMusic() async =>
      ZoneMusicEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<List<BriefZoneMusicEntity>> getBriefZoneMusics({
    int page = 1,
    ZoneMusicFilter? filter,
  }) async {
    final rows = await _applyFilter(
      laconic.table(_table).select(['ID', 'SetName', 'Sounds0', 'Sounds1']),
      filter,
    ).orderBy('ID').limit(kPageSize).offset((page - 1) * kPageSize).get();
    return rows
        .map((row) => BriefZoneMusicEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<ZoneMusicEntity>> getZoneMusics() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => ZoneMusicEntity.fromJson(row.toMap())).toList();
  }

  QueryBuilder _applyFilter(QueryBuilder builder, ZoneMusicFilter? filter) {
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
}
