class GameObjectQuestStarterEntity {
  final int id;
  final int quest;

  const GameObjectQuestStarterEntity({this.id = 0, this.quest = 0});

  factory GameObjectQuestStarterEntity.fromJson(Map<String, dynamic> json) {
    return GameObjectQuestStarterEntity(
      id: json['id'] ?? 0,
      quest: json['quest'] ?? 0,
    );
  }

  GameObjectQuestStarterEntity copyWith({int? id, int? quest}) {
    return GameObjectQuestStarterEntity(
      id: id ?? this.id,
      quest: quest ?? this.quest,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest};
  }
}
