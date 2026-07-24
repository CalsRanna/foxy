// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class CinematicSequenceFilterEntity {
  final String id;

  const CinematicSequenceFilterEntity({this.id = ''});

  factory CinematicSequenceFilterEntity.fromJson(Map<String, dynamic> json) {
    return CinematicSequenceFilterEntity(id: json['id']?.toString() ?? '');
  }

  CinematicSequenceFilterEntity copyWith({String? id}) {
    return CinematicSequenceFilterEntity(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
