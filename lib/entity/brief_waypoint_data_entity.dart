import 'package:foxy/entity/waypoint_data_key.dart';

/// The waypoint picker displays waypoints aggregated by path `id`;
/// `points` is the number of points on that path.
class BriefWaypointDataEntity {
  final int id;
  final int points;

  const BriefWaypointDataEntity({this.id = 0, this.points = 0});

  factory BriefWaypointDataEntity.fromJson(Map<String, dynamic> json) {
    return BriefWaypointDataEntity(
      id: json['id'] ?? 0,
      points: json['points'] ?? 0,
    );
  }

  WaypointDataKey get key => WaypointDataKey(id: id);
}
