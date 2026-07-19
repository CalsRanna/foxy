class CreatureQuestStarterEntity {
  final int id;
  final int quest;

  const CreatureQuestStarterEntity({this.id = 0, this.quest = 0});

  factory CreatureQuestStarterEntity.fromJson(Map<String, dynamic> json) {
    return CreatureQuestStarterEntity(
      id: json['id'] ?? 0,
      quest: json['quest'] ?? 0,
    );
  }

  CreatureQuestStarterEntity copyWith({int? id, int? quest}) {
    return CreatureQuestStarterEntity(
      id: id ?? this.id,
      quest: quest ?? this.quest,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest};
  }
}
