// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class CreatureImmunityFilterEntity {
  final String id;
  final String comment;

  const CreatureImmunityFilterEntity({this.id = '', this.comment = ''});

  factory CreatureImmunityFilterEntity.fromJson(Map<String, dynamic> json) {
    return CreatureImmunityFilterEntity(
      id: json['id']?.toString() ?? '',
      comment: json['comment']?.toString() ?? '',
    );
  }

  CreatureImmunityFilterEntity copyWith({String? id, String? comment}) {
    return CreatureImmunityFilterEntity(
      id: id ?? this.id,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'comment': comment};
  }
}
