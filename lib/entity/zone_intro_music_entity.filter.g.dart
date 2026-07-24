// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class ZoneIntroMusicFilterEntity {
  final String id;
  final String name;

  const ZoneIntroMusicFilterEntity({this.id = '', this.name = ''});

  factory ZoneIntroMusicFilterEntity.fromJson(Map<String, dynamic> json) {
    return ZoneIntroMusicFilterEntity(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ZoneIntroMusicFilterEntity copyWith({String? id, String? name}) {
    return ZoneIntroMusicFilterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
