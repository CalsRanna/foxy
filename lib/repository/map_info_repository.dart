import 'package:foxy/entity/map_info_entity.dart';
import 'package:foxy/entity/map_info_filter_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class MapInfoRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_map';

  @override
  String get dbcLocaleTableName => _table;

  Future<List<BriefMapInfoEntity>> getBriefMapInfos({
    int page = 1,
    MapInfoFilterEntity? filter,
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
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => BriefMapInfoEntity.fromJson(e.toMap())).toList();
  }

  Future<List<MapInfoEntity>> getMapInfos() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => MapInfoEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countMapInfos({MapInfoFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<MapInfoEntity?> getMapInfo(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return MapInfoEntity.fromJson(results.first.toMap());
  }

  Future<MapInfoEntity> createMapInfo() async {
    return MapInfoEntity(id: await _getNextId());
  }

  Future<int> storeMapInfo(MapInfoEntity map) async {
    var json = map.toJson();
    final nextId = map.id > 0 ? map.id : await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateMapInfo(MapInfoEntity map) async {
    var json = map.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', map.id).update(json);
  }

  Future<void> destroyMapInfo(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyMapInfo(int id) async {
    var source = await getMapInfo(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveMapInfo(MapInfoEntity map) async {
    if (map.id == 0) {
      await storeMapInfo(map);
      return;
    }
    var existing = await getMapInfo(map.id);
    if (existing != null) {
      await updateMapInfo(map);
    } else {
      await laconic.table(_table).insert([map.toJson()]);
    }
  }

  Future<List<DbcLocaleFieldValue>> getMapInfoLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveMapInfoLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);
  Future<int> _getNextId() async {
    return nextMaxPlusOne(_table, 'ID');
  }

  QueryBuilder _applyFilter(QueryBuilder builder, MapInfoFilterEntity? filter) {
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
