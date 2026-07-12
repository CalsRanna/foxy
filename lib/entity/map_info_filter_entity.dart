class MapInfoFilterEntity {
  final String id;
  final String name;

  const MapInfoFilterEntity({this.id = '', this.name = ''});

  factory MapInfoFilterEntity.fromJson(Map<String, dynamic> json) {
    return MapInfoFilterEntity(id: json['id'] ?? '', name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  MapInfoFilterEntity copyWith({String? id, String? name}) {
    return MapInfoFilterEntity(id: id ?? this.id, name: name ?? this.name);
  }
}
