class CreatureQuestStarter {
  final int id;
  final int quest;

  const CreatureQuestStarter({this.id = 0, this.quest = 0});

  factory CreatureQuestStarter.fromJson(Map<String, dynamic> json) {
    return CreatureQuestStarter(id: json['id'] ?? 0, quest: json['quest'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest};
  }
}

class BriefCreatureQuestStarter {
  final int id;
  final int quest;
  final String name;
  final String localeName;

  const BriefCreatureQuestStarter({
    this.id = 0,
    this.quest = 0,
    this.name = '',
    this.localeName = '',
  });

  factory BriefCreatureQuestStarter.fromJson(Map<String, dynamic> json) {
    return BriefCreatureQuestStarter(
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
