import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/map_info_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'map_info_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class MapInfoRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin, _MapInfoRepositoryMixin {
  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyMapInfo(int key) async {
    final source = await getMapInfo(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = MapInfoEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeMapInfo(copied);
    return copied.id;
  }

  Future<int> countMapInfos({
    MapInfoFilter? filter,
    bool nonInstanceableOnly = false,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    if (nonInstanceableOnly) {
      builder = builder.whereNotIn('InstanceType', [1, 2, 3, 4]);
    }
    return builder.count();
  }

  Future<MapInfoEntity> createMapInfo() async {
    return MapInfoEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefMapInfoEntity>> getBriefMapInfos({
    int page = 1,
    MapInfoFilter? filter,
    bool nonInstanceableOnly = false,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'ID',
      'MapName_lang_zhCN',
      'InstanceType',
      'PVP',
    ]);
    builder = _applyFilter(builder, filter);
    if (nonInstanceableOnly) {
      builder = builder.whereNotIn('InstanceType', [1, 2, 3, 4]);
    }
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => BriefMapInfoEntity.fromJson(e.toMap())).toList();
  }

  Future<List<MapInfoEntity>> getMapInfos() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => MapInfoEntity.fromJson(e.toMap())).toList();
  }

  QueryBuilder _applyFilter(QueryBuilder builder, MapInfoFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'MapName_lang_zhCN',
        '%${ParseUtil.escapeLike(filter.name)}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
