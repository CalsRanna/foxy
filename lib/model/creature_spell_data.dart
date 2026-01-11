/// 宠物技能数据
class CreatureSpellData {
  int id = 0;
  int spells1 = 0;
  int spells2 = 0;
  int spells3 = 0;
  int spells4 = 0;
  String spellName1 = '';
  String spellName2 = '';
  String spellName3 = '';
  String spellName4 = '';

  CreatureSpellData();

  CreatureSpellData.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? json['id'] ?? 0;
    spells1 = json['Spells_1'] ?? json['Spells1'] ?? json['spells1'] ?? 0;
    spells2 = json['Spells_2'] ?? json['Spells2'] ?? json['spells2'] ?? 0;
    spells3 = json['Spells_3'] ?? json['Spells3'] ?? json['spells3'] ?? 0;
    spells4 = json['Spells_4'] ?? json['Spells4'] ?? json['spells4'] ?? 0;
    spellName1 = json['SpellName1'] ?? '';
    spellName2 = json['SpellName2'] ?? '';
    spellName3 = json['SpellName3'] ?? '';
    spellName4 = json['SpellName4'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Spells_1': spells1,
      'Spells_2': spells2,
      'Spells_3': spells3,
      'Spells_4': spells4,
    };
  }
}
