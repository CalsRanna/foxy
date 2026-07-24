// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_trainer_entity.dart';

mixin _NpcTrainerEntityMixin {
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
    final self = this as NpcTrainerEntity;
    return NpcTrainerEntity(
      trainerId: trainerId ?? self.trainerId,
      spellId: spellId ?? self.spellId,
      moneyCost: moneyCost ?? self.moneyCost,
      reqSkillLine: reqSkillLine ?? self.reqSkillLine,
      reqSkillRank: reqSkillRank ?? self.reqSkillRank,
      reqAbility1: reqAbility1 ?? self.reqAbility1,
      reqAbility2: reqAbility2 ?? self.reqAbility2,
      reqAbility3: reqAbility3 ?? self.reqAbility3,
      reqLevel: reqLevel ?? self.reqLevel,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as NpcTrainerEntity;
    return {
      'TrainerId': self.trainerId,
      'SpellId': self.spellId,
      'MoneyCost': self.moneyCost,
      'ReqSkillLine': self.reqSkillLine,
      'ReqSkillRank': self.reqSkillRank,
      'ReqAbility1': self.reqAbility1,
      'ReqAbility2': self.reqAbility2,
      'ReqAbility3': self.reqAbility3,
      'ReqLevel': self.reqLevel,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as NpcTrainerEntity;
    return identical(self, other) ||
        other is NpcTrainerEntity &&
            self.runtimeType == other.runtimeType &&
            self.trainerId == other.trainerId &&
            self.spellId == other.spellId &&
            self.moneyCost == other.moneyCost &&
            self.reqSkillLine == other.reqSkillLine &&
            self.reqSkillRank == other.reqSkillRank &&
            self.reqAbility1 == other.reqAbility1 &&
            self.reqAbility2 == other.reqAbility2 &&
            self.reqAbility3 == other.reqAbility3 &&
            self.reqLevel == other.reqLevel &&
            self.verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    final self = this as NpcTrainerEntity;
    return Object.hashAll([
      self.runtimeType,
      self.trainerId,
      self.spellId,
      self.moneyCost,
      self.reqSkillLine,
      self.reqSkillRank,
      self.reqAbility1,
      self.reqAbility2,
      self.reqAbility3,
      self.reqLevel,
      self.verifiedBuild,
    ]);
  }

  @override
  String toString() {
    final self = this as NpcTrainerEntity;
    return 'NpcTrainerEntity('
        'trainerId: ${self.trainerId}, '
        'spellId: ${self.spellId}, '
        'moneyCost: ${self.moneyCost}, '
        'reqSkillLine: ${self.reqSkillLine}, '
        'reqSkillRank: ${self.reqSkillRank}, '
        'reqAbility1: ${self.reqAbility1}, '
        'reqAbility2: ${self.reqAbility2}, '
        'reqAbility3: ${self.reqAbility3}, '
        'reqLevel: ${self.reqLevel}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }
}

final class NpcTrainerKey {
  final int trainerId;
  final int spellId;

  const NpcTrainerKey({required this.trainerId, required this.spellId});

  factory NpcTrainerKey.fromEntity(NpcTrainerEntity entity) {
    return NpcTrainerKey(trainerId: entity.trainerId, spellId: entity.spellId);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NpcTrainerKey &&
            trainerId == other.trainerId &&
            spellId == other.spellId;
  }

  @override
  int get hashCode => Object.hashAll([trainerId, spellId]);

  @override
  String toString() {
    return 'NpcTrainerKey('
        'trainerId: $trainerId, '
        'spellId: $spellId'
        ')';
  }
}

final class BriefNpcTrainerEntity {
  final int trainerId;
  final int spellId;
  final int moneyCost;
  final int reqSkillLine;
  final int reqLevel;
  final String spellName;
  final String spellSubtext;

  const BriefNpcTrainerEntity({
    this.trainerId = 0,
    this.spellId = 0,
    this.moneyCost = 0,
    this.reqSkillLine = 0,
    this.reqLevel = 0,
    this.spellName = '',
    this.spellSubtext = '',
  });

  factory BriefNpcTrainerEntity.fromJson(Map<String, dynamic> json) {
    return BriefNpcTrainerEntity(
      trainerId: (json['TrainerId'] as num?)?.toInt() ?? 0,
      spellId: (json['SpellId'] as num?)?.toInt() ?? 0,
      moneyCost: (json['MoneyCost'] as num?)?.toInt() ?? 0,
      reqSkillLine: (json['ReqSkillLine'] as num?)?.toInt() ?? 0,
      reqLevel: (json['ReqLevel'] as num?)?.toInt() ?? 0,
      spellName: json['spellName']?.toString() ?? '',
      spellSubtext: json['spellSubtext']?.toString() ?? '',
    );
  }

  NpcTrainerKey get key {
    return NpcTrainerKey(trainerId: trainerId, spellId: spellId);
  }
}
