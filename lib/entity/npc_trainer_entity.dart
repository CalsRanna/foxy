/// NPC训练师 — 对应 npc_trainer 表（复合键: ID + SpellID）
class NpcTrainerEntity {
  final int id;
  final int spellID;
  final int moneyCost;
  final int reqSkillLine;
  final int reqSkillRank;
  final int reqLevel;
  final int reqSpell;

  const NpcTrainerEntity({
    this.id = 0,
    this.spellID = 0,
    this.moneyCost = 0,
    this.reqSkillLine = 0,
    this.reqSkillRank = 0,
    this.reqLevel = 0,
    this.reqSpell = 0,
  });

  factory NpcTrainerEntity.fromJson(Map<String, dynamic> json) {
    return NpcTrainerEntity(
      id: json['ID'] ?? 0,
      spellID: json['SpellID'] ?? 0,
      moneyCost: json['MoneyCost'] ?? 0,
      reqSkillLine: json['ReqSkillLine'] ?? 0,
      reqSkillRank: json['ReqSkillRank'] ?? 0,
      reqLevel: json['ReqLevel'] ?? 0,
      reqSpell: json['ReqSpell'] ?? 0,
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

/// NPC训练师列表展示模型（含 LEFT JOIN foxy.dbc_spell 的技能信息）
class BriefNpcTrainer {
  final int id;
  final int spellID;
  final int moneyCost;
  final int reqSkillLine;
  final int reqSkillRank;
  final int reqLevel;
  final int reqSpell;
  final String spellName;
  final String spellSubtext;

  const BriefNpcTrainer({
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

  factory BriefNpcTrainer.fromJson(Map<String, dynamic> json) {
    return BriefNpcTrainer(
      id: json['ID'] ?? 0,
      spellID: json['SpellID'] ?? 0,
      moneyCost: json['MoneyCost'] ?? 0,
      reqSkillLine: json['ReqSkillLine'] ?? 0,
      reqSkillRank: json['ReqSkillRank'] ?? 0,
      reqLevel: json['ReqLevel'] ?? 0,
      reqSpell: json['ReqSpell'] ?? 0,
      spellName: json['spellName'] ?? '',
      spellSubtext: json['spellSubtext'] ?? '',
    );
  }
}
