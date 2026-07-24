import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/map_info_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'map_info_repository.g.dart';

@FoxyRepository(MapInfoEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class MapInfoRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin, _MapInfoRepositoryMixin {
  static const _table = 'foxy.dbc_map';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyMapInfo(int key) async {
    final source = await getMapInfo(key);
    if (source == null) {
      throw StateError('原地图信息不存在，可能已被其他操作修改或删除');
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

  Future<List<DbcLocaleFieldValue>> getMapInfoLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<MapInfoEntity>> getMapInfos() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => MapInfoEntity.fromJson(e.toMap())).toList();
  }

  Future<void> saveMapInfoLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  QueryBuilder _applyFilter(QueryBuilder builder, MapInfoFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'MapName_lang_zhCN',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
