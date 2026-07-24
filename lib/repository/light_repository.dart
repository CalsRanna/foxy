import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/light_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'light_repository.g.dart';

@FoxyRepository(LightEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('continentId')
class LightRepository with RepositoryMixin, _LightRepositoryMixin {
  static const _table = 'foxy.dbc_light';

  Future<int> copyLight(int key) async {
    final source = await getLight(key);
    if (source == null) {
      throw StateError('原光照不存在，可能已被其他操作修改或删除');
    }
    final copied = LightEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeLight(copied);
    return copied.id;
  }

  Future<int> countLights({LightFilter? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<LightEntity> createLight() async =>
      LightEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<List<BriefLightEntity>> getBriefLights({
    int page = 1,
    LightFilter? filter,
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

  Future<List<LightEntity>> getLights() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => LightEntity.fromJson(row.toMap())).toList();
  }

  Future<void> storeLight(LightEntity entity) async {
    if (entity.id <= 0) {
      throw StateError('光照 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([entity.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('光照 ${entity.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, LightFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.continentId.isNotEmpty) {
      builder = builder.where('ContinentID', filter.continentId);
    }
    return builder;
  }
}
