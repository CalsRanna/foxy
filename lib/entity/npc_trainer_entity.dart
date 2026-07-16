/// 训练师技能列表展示模型（含 DBC 技能名称）。
class BriefNpcTrainerEntity {
  final int trainerId;
  final int spellId;
  final int moneyCost;
  final int reqSkillLine;
  final int reqSkillRank;
  final int reqAbility1;
  final int reqAbility2;
  final int reqAbility3;
  final int reqLevel;
  final int verifiedBuild;
  final String spellName;
  final String spellSubtext;

  const BriefNpcTrainerEntity({
    this.trainerId = 0,
    this.spellId = 0,
    this.moneyCost = 0,
    this.reqSkillLine = 0,
    this.reqSkillRank = 0,
    this.reqAbility1 = 0,
    this.reqAbility2 = 0,
    this.reqAbility3 = 0,
    this.reqLevel = 0,
    this.verifiedBuild = 0,
    this.spellName = '',
    this.spellSubtext = '',
  });

  factory BriefNpcTrainerEntity.fromJson(Map<String, dynamic> json) {
    return BriefNpcTrainerEntity(
      trainerId: json['TrainerId'] ?? 0,
      spellId: json['SpellId'] ?? 0,
      moneyCost: json['MoneyCost'] ?? 0,
      reqSkillLine: json['ReqSkillLine'] ?? 0,
      reqSkillRank: json['ReqSkillRank'] ?? 0,
      reqAbility1: json['ReqAbility1'] ?? 0,
      reqAbility2: json['ReqAbility2'] ?? 0,
      reqAbility3: json['ReqAbility3'] ?? 0,
      reqLevel: json['ReqLevel'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? 0,
      spellName: json['spellName'] ?? '',
      spellSubtext: json['spellSubtext'] ?? '',
    );
  }
}

/// 训练师技能 — 对应 trainer_spell 表（复合键: TrainerId + SpellId）。
class NpcTrainerEntity {
  final int trainerId;
  final int spellId;
  final int moneyCost;
  final int reqSkillLine;
  final int reqSkillRank;
  final int reqAbility1;
  final int reqAbility2;
  final int reqAbility3;
  final int reqLevel;
  final int verifiedBuild;

  const NpcTrainerEntity({
    this.trainerId = 0,
    this.spellId = 0,
    this.moneyCost = 0,
    this.reqSkillLine = 0,
    this.reqSkillRank = 0,
    this.reqAbility1 = 0,
    this.reqAbility2 = 0,
    this.reqAbility3 = 0,
    this.reqLevel = 0,
    this.verifiedBuild = 0,
  });

  factory NpcTrainerEntity.fromJson(Map<String, dynamic> json) {
    return NpcTrainerEntity(
      trainerId: json['TrainerId'] ?? 0,
      spellId: json['SpellId'] ?? 0,
      moneyCost: json['MoneyCost'] ?? 0,
      reqSkillLine: json['ReqSkillLine'] ?? 0,
      reqSkillRank: json['ReqSkillRank'] ?? 0,
      reqAbility1: json['ReqAbility1'] ?? 0,
      reqAbility2: json['ReqAbility2'] ?? 0,
      reqAbility3: json['ReqAbility3'] ?? 0,
      reqLevel: json['ReqLevel'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TrainerId': trainerId,
      'SpellId': spellId,
      'MoneyCost': moneyCost,
      'ReqSkillLine': reqSkillLine,
      'ReqSkillRank': reqSkillRank,
      'ReqAbility1': reqAbility1,
      'ReqAbility2': reqAbility2,
      'ReqAbility3': reqAbility3,
      'ReqLevel': reqLevel,
      'VerifiedBuild': verifiedBuild,
    };
  }
}
