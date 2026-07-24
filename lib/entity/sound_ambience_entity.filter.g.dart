// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class SoundAmbienceFilterEntity {
  final String id;

  const SoundAmbienceFilterEntity({this.id = ''});

  factory SoundAmbienceFilterEntity.fromJson(Map<String, dynamic> json) {
    return SoundAmbienceFilterEntity(id: json['id']?.toString() ?? '');
  }

  SoundAmbienceFilterEntity copyWith({String? id}) {
    return SoundAmbienceFilterEntity(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
