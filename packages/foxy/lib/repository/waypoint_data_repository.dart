import 'package:foxy/entity/brief_waypoint_data_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'waypoint_data_repository.g.dart';

/// The waypoint picker displays waypoints aggregated by path `id`
/// (points = COUNT(point)).
///
/// Aggregate results are not physical `waypoint_data` rows, so no
/// pseudo-CRUD is offered here.
@FoxyFilter.text('id')
class WaypointDataRepository with RepositoryMixin {
  static const _table = 'waypoint_data';

  Future<int> countWaypointDatas({WaypointDataFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    builder = builder.select(['id', 'count(point) as points']);
    builder = builder.groupBy('id');
    return builder.count();
  }

  Future<List<BriefWaypointDataEntity>> getBriefWaypointDatas({
    int page = 1,
    WaypointDataFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['id', 'count(point) as points']);
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
      builder = builder.where('id', int.tryParse(filter.id) ?? 0);
    }
    return builder;
  }
}
