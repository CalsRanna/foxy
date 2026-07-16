import 'package:foxy/entity/light_entity.dart';
import 'package:foxy/entity/light_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class LightRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_light';

  Future<void> copyLight(int id) async {
    final source = await getLight(id);
    if (source == null) return;
    final json = source.toJson()..['ID'] = await _getNextId();
    await laconic.table(_table).insert([json]);
  }

  Future<int> countLights({LightFilterEntity? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<LightEntity> createLight() async =>
      LightEntity(id: await _getNextId());

  Future<void> destroyLight(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefLightEntity>> getBriefLights({
    int page = 1,
    LightFilterEntity? filter,
  }) async {
    final rows = await _applyFilter(
      laconic.table(_table).select([
        'ID',
        'ContinentID',
        'GameCoords0',
        'GameCoords1',
        'GameCoords2',
      ]),
      filter,
    ).orderBy('ID').limit(kPageSize).offset((page - 1) * kPageSize).get();
    return rows.map((row) => BriefLightEntity.fromJson(row.toMap())).toList();
  }

  Future<LightEntity?> getLight(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    return rows.isEmpty ? null : LightEntity.fromJson(rows.first.toMap());
  }

  Future<List<LightEntity>> getLights() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => LightEntity.fromJson(row.toMap())).toList();
  }

  Future<void> saveLight(LightEntity entity) async {
    if (await getLight(entity.id) == null) {
      await storeLight(entity);
    } else {
      await updateLight(entity);
    }
  }

  Future<int> storeLight(LightEntity entity) async {
    final json = entity.toJson();
    final id = entity.id > 0 ? entity.id : await _getNextId();
    json['ID'] = id;
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateLight(LightEntity entity) async {
    final json = entity.toJson()..remove('ID');
    await laconic.table(_table).where('ID', entity.id).update(json);
  }

  QueryBuilder _applyFilter(QueryBuilder builder, LightFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.continentId.isNotEmpty) {
      builder = builder.where('ContinentID', filter.continentId);
    }
    return builder;
  }

  Future<int> _getNextId() => nextMaxPlusOne(_table, 'ID');
}
