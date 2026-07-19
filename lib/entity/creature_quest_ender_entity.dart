class CreatureQuestEnderEntity {
  final int id;
  final int quest;

  const CreatureQuestEnderEntity({this.id = 0, this.quest = 0});

  factory CreatureQuestEnderEntity.fromJson(Map<String, dynamic> json) {
    return CreatureQuestEnderEntity(
      id: json['id'] ?? 0,
      quest: json['quest'] ?? 0,
    );
  }

  CreatureQuestEnderEntity copyWith({int? id, int? quest}) {
    return CreatureQuestEnderEntity(
      id: id ?? this.id,
      quest: quest ?? this.quest,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest};
  }
}
