class WaypointData {
  int id = 0;
  int points = 0;

  WaypointData();

  factory WaypointData.fromJson(Map<String, dynamic> json) {
    return WaypointData()
      ..id = json['id'] ?? 0
      ..points = json['points'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'points': points,
    };
  }
}
