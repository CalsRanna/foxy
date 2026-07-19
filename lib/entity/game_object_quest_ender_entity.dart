class GameObjectQuestEnderEntity {
  final int id;
  final int quest;

  const GameObjectQuestEnderEntity({this.id = 0, this.quest = 0});

  factory GameObjectQuestEnderEntity.fromJson(Map<String, dynamic> json) {
    return GameObjectQuestEnderEntity(
      id: json['id'] ?? 0,
      quest: json['quest'] ?? 0,
    );
  }

  GameObjectQuestEnderEntity copyWith({int? id, int? quest}) {
    return GameObjectQuestEnderEntity(
      id: id ?? this.id,
      quest: quest ?? this.quest,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest};
  }
}
