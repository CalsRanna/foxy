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

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest};
  }
}

class BriefCreatureQuestStarterEntity {
  final int id;
  final int quest;
  final String name;
  final String localeName;

  const BriefCreatureQuestStarterEntity({
    this.id = 0,
    this.quest = 0,
    this.name = '',
    this.localeName = '',
  });

  factory BriefCreatureQuestStarterEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureQuestStarterEntity(
      id: json['id'] ?? 0,
      quest: json['quest'] ?? 0,
      name: json['name']?.toString() ?? '',
      localeName: json['Name']?.toString() ?? '',
    );
  }

  String get displayName => localeName.isNotEmpty ? localeName : name;

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest, 'name': name, 'Name': localeName};
  }
}
