/// 宠物技能数据列表展示模型（含 LEFT JOIN foxy.dbc_spell 的法术名）。
class BriefCreatureSpellDataEntity {
  final int id;
  final int spells0;
  final int spells1;
  final int spells2;
  final int spells3;
  final String spellName1;
  final String spellName2;
  final String spellName3;
  final String spellName4;

  const BriefCreatureSpellDataEntity({
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

  factory BriefCreatureSpellDataEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureSpellDataEntity(
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

  int get key => id;
}
