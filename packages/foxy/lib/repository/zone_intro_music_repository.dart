import 'package:foxy/entity/zone_intro_music_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'zone_intro_music_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class ZoneIntroMusicRepository
    with RepositoryMixin, _ZoneIntroMusicRepositoryMixin {
  static const _table = 'foxy.dbc_zone_intro_music_table';

  Future<int> copyZoneIntroMusic(int key) async {
    final source = await getZoneIntroMusic(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeZoneIntroMusic(copied);
    return copied.id;
  }

  Future<int> countZoneIntroMusics({ZoneIntroMusicFilter? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<ZoneIntroMusicEntity> createZoneIntroMusic() async =>
      ZoneIntroMusicEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<List<BriefZoneIntroMusicEntity>> getBriefZoneIntroMusics({
    int page = 1,
    ZoneIntroMusicFilter? filter,
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

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ZoneIntroMusicFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'Name',
        '%${escapeLike(filter.name)}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
