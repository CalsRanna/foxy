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

  NpcTrainerEntity copyWith({
    int? trainerId,
    int? spellId,
    int? moneyCost,
    int? reqSkillLine,
    int? reqSkillRank,
    int? reqAbility1,
    int? reqAbility2,
    int? reqAbility3,
    int? reqLevel,
    int? verifiedBuild,
  }) {
    return NpcTrainerEntity(
      trainerId: trainerId ?? this.trainerId,
      spellId: spellId ?? this.spellId,
      moneyCost: moneyCost ?? this.moneyCost,
      reqSkillLine: reqSkillLine ?? this.reqSkillLine,
      reqSkillRank: reqSkillRank ?? this.reqSkillRank,
      reqAbility1: reqAbility1 ?? this.reqAbility1,
      reqAbility2: reqAbility2 ?? this.reqAbility2,
      reqAbility3: reqAbility3 ?? this.reqAbility3,
      reqLevel: reqLevel ?? this.reqLevel,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
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
