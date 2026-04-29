import 'package:foxy/entity/waypoint_data_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class WaypointDataRepository with RepositoryMixin {
  static const _table = 'waypoint_data';

  Future<List<WaypointDataEntity>> getWaypointDatas({
    String? id,
    required int page,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['id', 'COUNT(point) as points']);
    builder = builder.groupBy('id');
    if (id != null && id.isNotEmpty) {
      builder = builder.where('id', id);
    }
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => WaypointDataEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countWaypointDatas({String? id}) async {
    var builder = laconic.table(_table);
    if (id != null && id.isNotEmpty) {
      builder = builder.where('id', id);
    }
    builder = builder.select(['id', 'COUNT(point) as points']);
    builder = builder.groupBy('id');
    return builder.count();
  }
}
