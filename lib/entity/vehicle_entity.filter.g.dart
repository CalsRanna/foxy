// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class VehicleFilterEntity {
  final String id;

  const VehicleFilterEntity({this.id = ''});

  factory VehicleFilterEntity.fromJson(Map<String, dynamic> json) {
    return VehicleFilterEntity(id: json['id']?.toString() ?? '');
  }

  VehicleFilterEntity copyWith({String? id}) {
    return VehicleFilterEntity(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
