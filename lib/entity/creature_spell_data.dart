/// 宠物技能数据 — 对应 foxy.dbc_creature_spell_data 表
class CreatureSpellData {
  final int id;
  final int spells0;
  final int spells1;
  final int spells2;
  final int spells3;
  final int availability0;
  final int availability1;
  final int availability2;
  final int availability3;

  const CreatureSpellData({
    this.id = 0,
    this.spells0 = 0,
    this.spells1 = 0,
    this.spells2 = 0,
    this.spells3 = 0,
    this.availability0 = 0,
    this.availability1 = 0,
    this.availability2 = 0,
    this.availability3 = 0,
  });

  factory CreatureSpellData.fromJson(Map<String, dynamic> json) {
    return CreatureSpellData(
      id: json['ID'] ?? 0,
      spells0: json['Spells0'] ?? 0,
      spells1: json['Spells1'] ?? 0,
      spells2: json['Spells2'] ?? 0,
      spells3: json['Spells3'] ?? 0,
      availability0: json['Availability0'] ?? 0,
      availability1: json['Availability1'] ?? 0,
      availability2: json['Availability2'] ?? 0,
      availability3: json['Availability3'] ?? 0,
    );
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

/// 宠物技能数据列表展示模型（含 LEFT JOIN foxy.dbc_spell 的法术名）
class BriefCreatureSpellData {
  final int id;
  final int spells0;
  final int spells1;
  final int spells2;
  final int spells3;
  final String spellName1;
  final String spellName2;
  final String spellName3;
  final String spellName4;

  const BriefCreatureSpellData({
    this.id = 0,
    this.spells0 = 0,
    this.spells1 = 0,
    this.spells2 = 0,
    this.spells3 = 0,
    this.spellName1 = '',
    this.spellName2 = '',
    this.spellName3 = '',
    this.spellName4 = '',
  });

  factory BriefCreatureSpellData.fromJson(Map<String, dynamic> json) {
    return BriefCreatureSpellData(
      id: json['ID'] ?? 0,
      spells0: json['Spells0'] ?? 0,
      spells1: json['Spells1'] ?? 0,
      spells2: json['Spells2'] ?? 0,
      spells3: json['Spells3'] ?? 0,
      spellName1: json['SpellName1'] ?? '',
      spellName2: json['SpellName2'] ?? '',
      spellName3: json['SpellName3'] ?? '',
      spellName4: json['SpellName4'] ?? '',
    );
  }
}
