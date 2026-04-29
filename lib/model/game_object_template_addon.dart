class GameObjectTemplateAddon {
  int entry = 0;
  int faction = 0;
  int flags = 0;
  int minGold = 0;
  int maxGold = 0;
  int artkit0 = 0;
  int artkit1 = 0;
  int artkit2 = 0;
  int artkit3 = 0;

  GameObjectTemplateAddon();

  factory GameObjectTemplateAddon.fromJson(Map<String, dynamic> json) {
    return GameObjectTemplateAddon()
      ..entry = json['entry'] ?? 0
      ..faction = json['faction'] ?? 0
      ..flags = json['flags'] ?? 0
      ..minGold = json['mingold'] ?? json['Mingold'] ?? 0
      ..maxGold = json['maxgold'] ?? json['Maxgold'] ?? 0
      ..artkit0 = json['artkit0'] ?? json['Artkit0'] ?? 0
      ..artkit1 = json['artkit1'] ?? json['Artkit1'] ?? 0
      ..artkit2 = json['artkit2'] ?? json['Artkit2'] ?? 0
      ..artkit3 = json['artkit3'] ?? json['Artkit3'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'faction': faction,
      'flags': flags,
      'mingold': minGold,
      'maxgold': maxGold,
      'artkit0': artkit0,
      'artkit1': artkit1,
      'artkit2': artkit2,
      'artkit3': artkit3,
    };
  }
}
