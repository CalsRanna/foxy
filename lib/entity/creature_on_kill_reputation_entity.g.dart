// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_on_kill_reputation_entity.dart';

mixin _CreatureOnKillReputationEntityMixin {
  static CreatureOnKillReputationEntity fromJson(Map<String, dynamic> json) {
    return CreatureOnKillReputationEntity(
      creatureID: (json['creature_id'] as num?)?.toInt() ?? 0,
      rewOnKillRepFaction1:
          (json['RewOnKillRepFaction1'] as num?)?.toInt() ?? 0,
      rewOnKillRepFaction2:
          (json['RewOnKillRepFaction2'] as num?)?.toInt() ?? 0,
      maxStanding1: (json['MaxStanding1'] as num?)?.toInt() ?? 0,
      maxStanding2: (json['MaxStanding2'] as num?)?.toInt() ?? 0,
      isTeamAward1: json['IsTeamAward1'] == null
          ? false
          : (json['IsTeamAward1'] as num).toInt() == 1,
      isTeamAward2: json['IsTeamAward2'] == null
          ? false
          : (json['IsTeamAward2'] as num).toInt() == 1,
      rewOnKillRepValue1:
          (json['RewOnKillRepValue1'] as num?)?.toDouble() ?? 0.0,
      rewOnKillRepValue2:
          (json['RewOnKillRepValue2'] as num?)?.toDouble() ?? 0.0,
      teamDependent: (json['TeamDependent'] as num?)?.toInt() ?? 0,
    );
  }

  CreatureOnKillReputationEntity copyWith({
    int? creatureID,
    int? rewOnKillRepFaction1,
    int? rewOnKillRepFaction2,
    int? maxStanding1,
    int? maxStanding2,
    bool? isTeamAward1,
    bool? isTeamAward2,
    double? rewOnKillRepValue1,
    double? rewOnKillRepValue2,
    int? teamDependent,
  }) {
    final self = this as CreatureOnKillReputationEntity;
    return CreatureOnKillReputationEntity(
      creatureID: creatureID ?? self.creatureID,
      rewOnKillRepFaction1: rewOnKillRepFaction1 ?? self.rewOnKillRepFaction1,
      rewOnKillRepFaction2: rewOnKillRepFaction2 ?? self.rewOnKillRepFaction2,
      maxStanding1: maxStanding1 ?? self.maxStanding1,
      maxStanding2: maxStanding2 ?? self.maxStanding2,
      isTeamAward1: isTeamAward1 ?? self.isTeamAward1,
      isTeamAward2: isTeamAward2 ?? self.isTeamAward2,
      rewOnKillRepValue1: rewOnKillRepValue1 ?? self.rewOnKillRepValue1,
      rewOnKillRepValue2: rewOnKillRepValue2 ?? self.rewOnKillRepValue2,
      teamDependent: teamDependent ?? self.teamDependent,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CreatureOnKillReputationEntity;
    return {
      'creature_id': self.creatureID,
      'RewOnKillRepFaction1': self.rewOnKillRepFaction1,
      'RewOnKillRepFaction2': self.rewOnKillRepFaction2,
      'MaxStanding1': self.maxStanding1,
      'MaxStanding2': self.maxStanding2,
      'IsTeamAward1': self.isTeamAward1 ? 1 : 0,
      'IsTeamAward2': self.isTeamAward2 ? 1 : 0,
      'RewOnKillRepValue1': self.rewOnKillRepValue1,
      'RewOnKillRepValue2': self.rewOnKillRepValue2,
      'TeamDependent': self.teamDependent,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as CreatureOnKillReputationEntity;
    return identical(self, other) ||
        other is CreatureOnKillReputationEntity &&
            self.runtimeType == other.runtimeType &&
            self.creatureID == other.creatureID &&
            self.rewOnKillRepFaction1 == other.rewOnKillRepFaction1 &&
            self.rewOnKillRepFaction2 == other.rewOnKillRepFaction2 &&
            self.maxStanding1 == other.maxStanding1 &&
            self.maxStanding2 == other.maxStanding2 &&
            self.isTeamAward1 == other.isTeamAward1 &&
            self.isTeamAward2 == other.isTeamAward2 &&
            self.rewOnKillRepValue1 == other.rewOnKillRepValue1 &&
            self.rewOnKillRepValue2 == other.rewOnKillRepValue2 &&
            self.teamDependent == other.teamDependent;
  }

  @override
  int get hashCode {
    final self = this as CreatureOnKillReputationEntity;
    return Object.hashAll([
      self.runtimeType,
      self.creatureID,
      self.rewOnKillRepFaction1,
      self.rewOnKillRepFaction2,
      self.maxStanding1,
      self.maxStanding2,
      self.isTeamAward1,
      self.isTeamAward2,
      self.rewOnKillRepValue1,
      self.rewOnKillRepValue2,
      self.teamDependent,
    ]);
  }

  @override
  String toString() {
    final self = this as CreatureOnKillReputationEntity;
    return 'CreatureOnKillReputationEntity('
        'creatureID: ${self.creatureID}, '
        'rewOnKillRepFaction1: ${self.rewOnKillRepFaction1}, '
        'rewOnKillRepFaction2: ${self.rewOnKillRepFaction2}, '
        'maxStanding1: ${self.maxStanding1}, '
        'maxStanding2: ${self.maxStanding2}, '
        'isTeamAward1: ${self.isTeamAward1}, '
        'isTeamAward2: ${self.isTeamAward2}, '
        'rewOnKillRepValue1: ${self.rewOnKillRepValue1}, '
        'rewOnKillRepValue2: ${self.rewOnKillRepValue2}, '
        'teamDependent: ${self.teamDependent}'
        ')';
  }
}

final class BriefCreatureOnKillReputationEntity {
  final int creatureID;
  final int rewOnKillRepFaction1;
  final int rewOnKillRepFaction2;
  final double rewOnKillRepValue1;
  final double rewOnKillRepValue2;
  final int teamDependent;

  const BriefCreatureOnKillReputationEntity({
    this.creatureID = 0,
    this.rewOnKillRepFaction1 = 0,
    this.rewOnKillRepFaction2 = 0,
    this.rewOnKillRepValue1 = 0.0,
    this.rewOnKillRepValue2 = 0.0,
    this.teamDependent = 0,
  });

  factory BriefCreatureOnKillReputationEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefCreatureOnKillReputationEntity(
      creatureID: (json['creature_id'] as num?)?.toInt() ?? 0,
      rewOnKillRepFaction1:
          (json['RewOnKillRepFaction1'] as num?)?.toInt() ?? 0,
      rewOnKillRepFaction2:
          (json['RewOnKillRepFaction2'] as num?)?.toInt() ?? 0,
      rewOnKillRepValue1:
          (json['RewOnKillRepValue1'] as num?)?.toDouble() ?? 0.0,
      rewOnKillRepValue2:
          (json['RewOnKillRepValue2'] as num?)?.toDouble() ?? 0.0,
      teamDependent: (json['TeamDependent'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => creatureID;
}
