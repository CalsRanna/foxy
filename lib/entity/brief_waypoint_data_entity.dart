import 'package:foxy/entity/waypoint_data_key.dart';

/// 路径点选择器按 path `id` 聚合展示，`points` 是该路径的点位数量。
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
