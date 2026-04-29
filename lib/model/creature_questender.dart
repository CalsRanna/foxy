class CreatureQuestender {
  final int id;
  final int quest;

  const CreatureQuestender({this.id = 0, this.quest = 0});

  factory CreatureQuestender.fromJson(Map<String, dynamic> json) {
    return CreatureQuestender(
      id: json['id'] ?? 0,
      quest: json['quest'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest};
  }
}

class BriefCreatureQuestender {
  final int id;
  final int quest;
  final String name;
  final String localeName;

  const BriefCreatureQuestender({
    this.id = 0,
    this.quest = 0,
    this.name = '',
    this.localeName = '',
  });

  factory BriefCreatureQuestender.fromJson(Map<String, dynamic> json) {
    return BriefCreatureQuestender(
      id: json['id'] ?? 0,
      quest: json['quest'] ?? 0,
      name: json['name']?.toString() ?? '',
      localeName: json['Name']?.toString() ?? '',
    );
  }

  String get displayName => localeName.isNotEmpty ? localeName : name;
}
