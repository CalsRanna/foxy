// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_trainer_entity.dart';

mixin _NpcTrainerEntityMixin {
  int get trainerId;
  int get spellId;
  int get moneyCost;
  int get reqSkillLine;
  int get reqSkillRank;
  int get reqAbility1;
  int get reqAbility2;
  int get reqAbility3;
  int get reqLevel;
  int get verifiedBuild;

  static NpcTrainerEntity fromJson(Map<String, dynamic> json) {
    return NpcTrainerEntity(
      trainerId: (json['TrainerId'] as num?)?.toInt() ?? 0,
      spellId: (json['SpellId'] as num?)?.toInt() ?? 0,
      moneyCost: (json['MoneyCost'] as num?)?.toInt() ?? 0,
      reqSkillLine: (json['ReqSkillLine'] as num?)?.toInt() ?? 0,
      reqSkillRank: (json['ReqSkillRank'] as num?)?.toInt() ?? 0,
      reqAbility1: (json['ReqAbility1'] as num?)?.toInt() ?? 0,
      reqAbility2: (json['ReqAbility2'] as num?)?.toInt() ?? 0,
      reqAbility3: (json['ReqAbility3'] as num?)?.toInt() ?? 0,
      reqLevel: (json['ReqLevel'] as num?)?.toInt() ?? 0,
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NpcTrainerEntity &&
            runtimeType == other.runtimeType &&
            trainerId == other.trainerId &&
            spellId == other.spellId &&
            moneyCost == other.moneyCost &&
            reqSkillLine == other.reqSkillLine &&
            reqSkillRank == other.reqSkillRank &&
            reqAbility1 == other.reqAbility1 &&
            reqAbility2 == other.reqAbility2 &&
            reqAbility3 == other.reqAbility3 &&
            reqLevel == other.reqLevel &&
            verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      trainerId,
      spellId,
      moneyCost,
      reqSkillLine,
      reqSkillRank,
      reqAbility1,
      reqAbility2,
      reqAbility3,
      reqLevel,
      verifiedBuild,
    ]);
  }

  @override
  String toString() {
    return 'NpcTrainerEntity('
        'trainerId: $trainerId, '
        'spellId: $spellId, '
        'moneyCost: $moneyCost, '
        'reqSkillLine: $reqSkillLine, '
        'reqSkillRank: $reqSkillRank, '
        'reqAbility1: $reqAbility1, '
        'reqAbility2: $reqAbility2, '
        'reqAbility3: $reqAbility3, '
        'reqLevel: $reqLevel, '
        'verifiedBuild: $verifiedBuild'
        ')';
  }
}
