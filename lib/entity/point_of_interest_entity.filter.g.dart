// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class PointOfInterestFilterEntity {
  final String id;
  final String name;

  const PointOfInterestFilterEntity({this.id = '', this.name = ''});

  factory PointOfInterestFilterEntity.fromJson(Map<String, dynamic> json) {
    return PointOfInterestFilterEntity(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  PointOfInterestFilterEntity copyWith({String? id, String? name}) {
    return PointOfInterestFilterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
