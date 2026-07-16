class WaypointDataFilterEntity {
  final String id;

  const WaypointDataFilterEntity({this.id = ''});

  factory WaypointDataFilterEntity.fromJson(Map<String, dynamic> json) {
    return WaypointDataFilterEntity(id: json['id'] ?? '');
  }

  WaypointDataFilterEntity copyWith({String? id}) {
    return WaypointDataFilterEntity(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
