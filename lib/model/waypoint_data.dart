class WaypointData {
  final int id;
  final int points;

  const WaypointData({this.id = 0, this.points = 0});

  factory WaypointData.fromJson(Map<String, dynamic> json) {
    return WaypointData(
      id: json['id'] ?? 0,
      points: json['points'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'points': points};
  }
}
