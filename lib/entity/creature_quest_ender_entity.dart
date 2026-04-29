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

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest};
  }
}

class BriefCreatureQuestEnder {
  final int id;
  final int quest;
  final String name;
  final String localeName;

  const BriefCreatureQuestEnder({
    this.id = 0,
    this.quest = 0,
    this.name = '',
    this.localeName = '',
  });

  factory BriefCreatureQuestEnder.fromJson(Map<String, dynamic> json) {
    return BriefCreatureQuestEnder(
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
