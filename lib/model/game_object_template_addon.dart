class GameObjectTemplateAddon {
  int entry = 0;
  int faction = 0;
  int flags = 0;
  int minGold = 0;
  int maxGold = 0;

  GameObjectTemplateAddon();

  GameObjectTemplateAddon.fromJson(Map<String, dynamic> json) {
    entry = json['entry'] ?? 0;
    faction = json['faction'] ?? 0;
    flags = json['flags'] ?? 0;
    minGold = json['mingold'] ?? 0;
    maxGold = json['maxgold'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'faction': faction,
      'flags': flags,
      'mingold': minGold,
      'maxgold': maxGold,
    };
  }
}
