class CreatureQueststarter {
  final int id;
  final int quest;

  const CreatureQueststarter({this.id = 0, this.quest = 0});

  factory CreatureQueststarter.fromJson(Map<String, dynamic> json) {
    return CreatureQueststarter(
      id: json['id'] ?? 0,
      quest: json['quest'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest};
  }
}

class BriefCreatureQueststarter {
  final int id;
  final int quest;
  final String name;
  final String localeName;

  const BriefCreatureQueststarter({
    this.id = 0,
    this.quest = 0,
    this.name = '',
    this.localeName = '',
  });

  factory BriefCreatureQueststarter.fromJson(Map<String, dynamic> json) {
    return BriefCreatureQueststarter(
      id: json['id'] ?? 0,
      quest: json['quest'] ?? 0,
      name: json['name']?.toString() ?? '',
      localeName: json['Name']?.toString() ?? '',
    );
  }

  String get displayName => localeName.isNotEmpty ? localeName : name;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quest': quest,
      'name': name,
      'Name': localeName,
    };
  }
}
