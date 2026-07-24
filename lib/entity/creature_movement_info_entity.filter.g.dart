// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class CreatureMovementInfoFilterEntity {
  final String id;

  const CreatureMovementInfoFilterEntity({this.id = ''});

  factory CreatureMovementInfoFilterEntity.fromJson(Map<String, dynamic> json) {
    return CreatureMovementInfoFilterEntity(id: json['id']?.toString() ?? '');
  }

  CreatureMovementInfoFilterEntity copyWith({String? id}) {
    return CreatureMovementInfoFilterEntity(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
