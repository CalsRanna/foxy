/// 生物模板技能
class CreatureTemplateSpell {
  int creatureID = 0;
  int index = 0;
  int spell = 0;
  int verifiedBuild = 0;

  // 关联字段（技能信息）
  String spellName = '';
  String spellSubtext = '';

  CreatureTemplateSpell();

  CreatureTemplateSpell.fromJson(Map<String, dynamic> json) {
    creatureID = json['CreatureID'] ?? json['creatureID'] ?? 0;
    index = json['Index'] ?? json['index'] ?? 0;
    spell = json['Spell'] ?? json['spell'] ?? 0;
    verifiedBuild = json['VerifiedBuild'] ?? json['verifiedBuild'] ?? 0;
    // 关联字段
    spellName = json['spellName'] ?? '';
    spellSubtext = json['spellSubtext'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'CreatureID': creatureID,
      'Index': index,
      'Spell': spell,
      'VerifiedBuild': verifiedBuild,
    };
  }
}
