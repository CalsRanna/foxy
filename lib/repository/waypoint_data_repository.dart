import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/brief_waypoint_data_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'waypoint_data_repository.g.dart';

/// 路径点选择器按 path `id` 聚合展示（points = COUNT(point)）。
///
/// 聚合结果不是 `waypoint_data` 的物理行，不在此仓储提供伪 CRUD。
@FoxyRepositoryFilter(
  name: 'WaypointDataFilter',
  fields: [
    FoxyRepositoryFilterField(
      name: 'id',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
  ],
)
class WaypointDataRepository with RepositoryMixin {
  static const _table = 'waypoint_data';

  Future<int> countWaypointDatas({WaypointDataFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    builder = builder.select(['id', 'COUNT(point) as points']);
    builder = builder.groupBy('id');
    return builder.count();
  }

  Future<List<BriefWaypointDataEntity>> getBriefWaypointDatas({
    int page = 1,
    WaypointDataFilter? filter,
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

  QueryBuilder _applyFilter(QueryBuilder builder, WaypointDataFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('id', filter.id);
    }
    return builder;
  }
}
