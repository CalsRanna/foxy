class GameObjectTemplateAddon {
  final int entry;
  final int faction;
  final int flags;
  final int minGold;
  final int maxGold;
  final int artkit0;
  final int artkit1;
  final int artkit2;
  final int artkit3;

  const GameObjectTemplateAddon({
    this.entry = 0,
    this.faction = 0,
    this.flags = 0,
    this.minGold = 0,
    this.maxGold = 0,
    this.artkit0 = 0,
    this.artkit1 = 0,
    this.artkit2 = 0,
    this.artkit3 = 0,
  });

  factory GameObjectTemplateAddon.fromJson(Map<String, dynamic> json) {
    return GameObjectTemplateAddon(
      entry: json['entry'] ?? 0,
      faction: json['faction'] ?? 0,
      flags: json['flags'] ?? 0,
      minGold: json['mingold'] ?? json['Mingold'] ?? 0,
      maxGold: json['maxgold'] ?? json['Maxgold'] ?? 0,
      artkit0: json['artkit0'] ?? json['Artkit0'] ?? 0,
      artkit1: json['artkit1'] ?? json['Artkit1'] ?? 0,
      artkit2: json['artkit2'] ?? json['Artkit2'] ?? 0,
      artkit3: json['artkit3'] ?? json['Artkit3'] ?? 0,
    );
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
