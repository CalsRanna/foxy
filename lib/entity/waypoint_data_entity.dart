class WaypointDataEntity {
  final int id;
  final int points;

  const WaypointDataEntity({this.id = 0, this.points = 0});

  factory WaypointDataEntity.fromJson(Map<String, dynamic> json) {
    return WaypointDataEntity(id: json['id'] ?? 0, points: json['points'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'points': points};
  }

  WaypointDataEntity copyWith({int? id, int? points}) {
    return WaypointDataEntity(id: id ?? this.id, points: points ?? this.points);
  }
}

/// 路径点数据列表/Picker 展示模型（按 path id 聚合）
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

  Map<String, dynamic> toJson() {
    return {'id': id, 'points': points};
  }

  BriefWaypointDataEntity copyWith({int? id, int? points}) {
    return BriefWaypointDataEntity(
      id: id ?? this.id,
      points: points ?? this.points,
    );
  }
}
