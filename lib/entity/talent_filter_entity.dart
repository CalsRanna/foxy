class TalentFilterEntity {
  final String id;
  final String spell;

  const TalentFilterEntity({this.id = '', this.spell = ''});

  factory TalentFilterEntity.fromJson(Map<String, dynamic> json) {
    return TalentFilterEntity(
      id: json['id'] ?? '',
      spell: json['spell'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'spell': spell};
  }

  TalentFilterEntity copyWith({
    String? id,
    String? spell,
  }) {
    return TalentFilterEntity(
      id: id ?? this.id,
      spell: spell ?? this.spell,
    );
  }
}
