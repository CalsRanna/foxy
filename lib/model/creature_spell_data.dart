/// 宠物技能数据
class CreatureSpellData {
  int id = 0;
  int spells1 = 0;
  int spells2 = 0;
  int spells3 = 0;
  int spells4 = 0;

  CreatureSpellData();

  CreatureSpellData.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? json['id'] ?? 0;
    spells1 = json['Spells1'] ?? json['spells1'] ?? 0;
    spells2 = json['Spells2'] ?? json['spells2'] ?? 0;
    spells3 = json['Spells3'] ?? json['spells3'] ?? 0;
    spells4 = json['Spells4'] ?? json['spells4'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Spells1': spells1,
      'Spells2': spells2,
      'Spells3': spells3,
      'Spells4': spells4,
    };
  }
}
