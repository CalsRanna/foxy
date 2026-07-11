class VehicleFilterEntity {
  final String id;

  const VehicleFilterEntity({this.id = ''});

  factory VehicleFilterEntity.fromJson(Map<String, dynamic> json) {
    return VehicleFilterEntity(id: json['id'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }

  VehicleFilterEntity copyWith({String? id}) {
    return VehicleFilterEntity(id: id ?? this.id);
  }
}
