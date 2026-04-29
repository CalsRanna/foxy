/// 宠物技能数据
class CreatureSpellData {
  int id = 0;
  int spells0 = 0;
  int spells1 = 0;
  int spells2 = 0;
  int spells3 = 0;
  int availability0 = 0;
  int availability1 = 0;
  int availability2 = 0;
  int availability3 = 0;
  String spellName1 = '';
  String spellName2 = '';
  String spellName3 = '';
  String spellName4 = '';

  CreatureSpellData();

  factory CreatureSpellData.fromJson(Map<String, dynamic> json) {
    return CreatureSpellData()
      ..id = json['ID'] ?? json['id'] ?? 0
      ..spells0 = json['Spells0'] ?? 0
      ..spells1 = json['Spells1'] ?? 0
      ..spells2 = json['Spells2'] ?? 0
      ..spells3 = json['Spells3'] ?? 0
      ..availability0 = json['Availability0'] ?? 0
      ..availability1 = json['Availability1'] ?? 0
      ..availability2 = json['Availability2'] ?? 0
      ..availability3 = json['Availability3'] ?? 0
      ..spellName1 = json['SpellName1'] ?? ''
      ..spellName2 = json['SpellName2'] ?? ''
      ..spellName3 = json['SpellName3'] ?? ''
      ..spellName4 = json['SpellName4'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Spells0': spells0,
      'Spells1': spells1,
      'Spells2': spells2,
      'Spells3': spells3,
      'Availability0': availability0,
      'Availability1': availability1,
      'Availability2': availability2,
      'Availability3': availability3,
    };
  }
}
