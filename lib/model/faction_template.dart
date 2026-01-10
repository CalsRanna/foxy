/// 阵营模板
class FactionTemplate {
  int id = 0;
  int faction = 0;
  int flags = 0;

  FactionTemplate();

  FactionTemplate.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? json['id'] ?? 0;
    faction = json['Faction'] ?? json['faction'] ?? 0;
    flags = json['Flags'] ?? json['flags'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'Faction': faction, 'Flags': flags};
  }
}
