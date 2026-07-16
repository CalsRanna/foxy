import 'package:foxy/entity/waypoint_data_entity.dart';
import 'package:foxy/entity/waypoint_data_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

/// 路径点表按 path `id` 聚合展示（points = COUNT(point)）。
/// 写操作以 path id 为粒度：destroy/copy 作用于该 id 下全部 point 行。
class WaypointDataRepository with RepositoryMixin {
  static const _table = 'waypoint_data';

  Future<void> copyWaypointData(int id) async {
    var rows = await laconic.table(_table).where('id', id).get();
    if (rows.isEmpty) return;
    var nextId = await nextMaxPlusOne(_table, 'id');
    var inserts = rows.map((row) {
      var json = Map<String, dynamic>.from(row.toMap());
      json['id'] = nextId;
      return json;
    }).toList();
    await laconic.table(_table).insert(inserts);
  }

  Future<int> countWaypointDatas({WaypointDataFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    builder = builder.select(['id', 'COUNT(point) as points']);
    builder = builder.groupBy('id');
    return builder.count();
  }

  Future<WaypointDataEntity> createWaypointData() async {
    return WaypointDataEntity(id: await nextMaxPlusOne(_table, 'id'));
  }

  Future<void> destroyWaypointData(int id) async {
    await laconic.table(_table).where('id', id).delete();
  }

  Future<List<BriefWaypointDataEntity>> getBriefWaypointDatas({
    int page = 1,
    WaypointDataFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['id', 'COUNT(point) as points']);
    builder = builder.groupBy('id');
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('id');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefWaypointDataEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<WaypointDataEntity?> getWaypointData(int id) async {
    var builder = laconic.table(_table);
    builder = builder.select(['id', 'COUNT(point) as points']);
    builder = builder.where('id', id);
    builder = builder.groupBy('id');
    builder = builder.limit(1);
    var results = await builder.get();
    if (results.isEmpty) return null;
    return WaypointDataEntity.fromJson(results.first.toMap());
  }

  Future<List<WaypointDataEntity>> getWaypointDatas() async {
    var builder = laconic.table(_table);
    builder = builder.select(['id', 'COUNT(point) as points']);
    builder = builder.groupBy('id');
    var results = await builder.get();
    return results.map((e) => WaypointDataEntity.fromJson(e.toMap())).toList();
  }

  Future<void> saveWaypointData(WaypointDataEntity data) async {
    if (data.id == 0) {
      await storeWaypointData(data);
      return;
    }
    var existing = await getWaypointData(data.id);
    if (existing != null) {
      await updateWaypointData(data);
    }
  }

  /// 仅分配下一 path id，不插入 point 行（聚合实体无点位数据）。
  Future<int> storeWaypointData(WaypointDataEntity data) async {
    return nextMaxPlusOne(_table, 'id');
  }

  /// 聚合实体无可更新字段，空操作。
  Future<void> updateWaypointData(WaypointDataEntity data) async {}

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    WaypointDataFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('id', filter.id);
    }
    return builder;
  }
}
