/// NPC训练师
class NpcTrainer {
  final int id;
  final int spellID;
  final int moneyCost;
  final int reqSkillLine;
  final int reqSkillRank;
  final int reqLevel;
  final int reqSpell;

  // 关联字段（技能信息）
  final String spellName;
  final String spellSubtext;

  const NpcTrainer({
    this.id = 0,
    this.spellID = 0,
    this.moneyCost = 0,
    this.reqSkillLine = 0,
    this.reqSkillRank = 0,
    this.reqLevel = 0,
    this.reqSpell = 0,
    this.spellName = '',
    this.spellSubtext = '',
  });

  factory NpcTrainer.fromJson(Map<String, dynamic> json) {
    return NpcTrainer(
      id: json['ID'] ?? json['id'] ?? 0,
      spellID: json['SpellID'] ?? json['spellID'] ?? 0,
      moneyCost: json['MoneyCost'] ?? json['moneyCost'] ?? 0,
      reqSkillLine: json['ReqSkillLine'] ?? json['reqSkillLine'] ?? 0,
      reqSkillRank: json['ReqSkillRank'] ?? json['reqSkillRank'] ?? 0,
      reqLevel: json['ReqLevel'] ?? json['reqLevel'] ?? 0,
      reqSpell: json['ReqSpell'] ?? json['reqSpell'] ?? 0,
      spellName: json['spellName'] ?? '',
      spellSubtext: json['spellSubtext'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'SpellID': spellID,
      'MoneyCost': moneyCost,
      'ReqSkillLine': reqSkillLine,
      'ReqSkillRank': reqSkillRank,
      'ReqLevel': reqLevel,
      'ReqSpell': reqSpell,
    };
  }
}
