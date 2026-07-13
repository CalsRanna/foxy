class CreatureImmunityFilterEntity {
  final String id;
  final String comment;

  const CreatureImmunityFilterEntity({this.id = '', this.comment = ''});

  factory CreatureImmunityFilterEntity.fromJson(Map<String, dynamic> json) {
    return CreatureImmunityFilterEntity(
      id: json['id'] ?? '',
      comment: json['comment'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'comment': comment};

  CreatureImmunityFilterEntity copyWith({String? id, String? comment}) {
    return CreatureImmunityFilterEntity(
      id: id ?? this.id,
      comment: comment ?? this.comment,
    );
  }
}
