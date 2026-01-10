/// NPC训练师
class NpcTrainer {
  int id = 0;
  int spellID = 0;
  int moneyCost = 0;
  int reqSkillLine = 0;
  int reqSkillRank = 0;
  int reqLevel = 0;

  // 关联字段（技能信息）
  String spellName = '';
  String spellSubtext = '';

  NpcTrainer();

  NpcTrainer.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? json['id'] ?? 0;
    spellID = json['SpellID'] ?? json['spellID'] ?? 0;
    moneyCost = json['MoneyCost'] ?? json['moneyCost'] ?? 0;
    reqSkillLine = json['ReqSkillLine'] ?? json['reqSkillLine'] ?? 0;
    reqSkillRank = json['ReqSkillRank'] ?? json['reqSkillRank'] ?? 0;
    reqLevel = json['ReqLevel'] ?? json['reqLevel'] ?? 0;
    // 关联字段
    spellName = json['spellName'] ?? '';
    spellSubtext = json['spellSubtext'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'SpellID': spellID,
      'MoneyCost': moneyCost,
      'ReqSkillLine': reqSkillLine,
      'ReqSkillRank': reqSkillRank,
      'ReqLevel': reqLevel,
    };
  }
}
