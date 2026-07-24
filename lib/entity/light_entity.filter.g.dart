// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class LightFilterEntity {
  final String id;
  final String continentId;

  const LightFilterEntity({this.id = '', this.continentId = ''});

  factory LightFilterEntity.fromJson(Map<String, dynamic> json) {
    return LightFilterEntity(
      id: json['id']?.toString() ?? '',
      continentId: json['continentId']?.toString() ?? '',
    );
  }

  LightFilterEntity copyWith({String? id, String? continentId}) {
    return LightFilterEntity(
      id: id ?? this.id,
      continentId: continentId ?? this.continentId,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'continentId': continentId};
  }
}
