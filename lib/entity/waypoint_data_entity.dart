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
}
