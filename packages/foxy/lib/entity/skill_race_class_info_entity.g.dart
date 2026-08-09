// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_race_class_info_entity.dart';

final class BriefSkillRaceClassInfoEntity {
  final int id;

  const BriefSkillRaceClassInfoEntity({this.id = 0});

  factory BriefSkillRaceClassInfoEntity.fromJson(Map<String, dynamic> json) {
    return BriefSkillRaceClassInfoEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  int get hashCode => Object.hashAll([id]);

  int get key => id;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefSkillRaceClassInfoEntity && id == other.id;
  }

  @override
  String toString() {
    return 'BriefSkillRaceClassInfoEntity('
        'id: $id'
        ')';
  }
}

mixin _SkillRaceClassInfoEntityMixin {
  @override
  int get hashCode {
    final self = this as SkillRaceClassInfoEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.skillId,
      self.raceMask,
      self.classMask,
      self.flags,
      self.minLevel,
      self.skillTierId,
      self.skillCostIndex,
    ]);
  }

  @override
  bool operator ==(Object other) {
    final self = this as SkillRaceClassInfoEntity;
    return identical(self, other) ||
        other is SkillRaceClassInfoEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.skillId == other.skillId &&
            self.raceMask == other.raceMask &&
            self.classMask == other.classMask &&
            self.flags == other.flags &&
            self.minLevel == other.minLevel &&
            self.skillTierId == other.skillTierId &&
            self.skillCostIndex == other.skillCostIndex;
  }

  SkillRaceClassInfoEntity copyWith({
    int? id,
    int? skillId,
    int? raceMask,
    int? classMask,
    int? flags,
    int? minLevel,
    int? skillTierId,
    int? skillCostIndex,
  }) {
    final self = this as SkillRaceClassInfoEntity;
    return SkillRaceClassInfoEntity(
      id: id ?? self.id,
      skillId: skillId ?? self.skillId,
      raceMask: raceMask ?? self.raceMask,
      classMask: classMask ?? self.classMask,
      flags: flags ?? self.flags,
      minLevel: minLevel ?? self.minLevel,
      skillTierId: skillTierId ?? self.skillTierId,
      skillCostIndex: skillCostIndex ?? self.skillCostIndex,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SkillRaceClassInfoEntity;
    return {
      'ID': self.id,
      'SkillID': self.skillId,
      'RaceMask': self.raceMask,
      'ClassMask': self.classMask,
      'Flags': self.flags,
      'MinLevel': self.minLevel,
      'SkillTierID': self.skillTierId,
      'SkillCostIndex': self.skillCostIndex,
    };
  }

  @override
  String toString() {
    final self = this as SkillRaceClassInfoEntity;
    return 'SkillRaceClassInfoEntity('
        'id: ${self.id}, '
        'skillId: ${self.skillId}, '
        'raceMask: ${self.raceMask}, '
        'classMask: ${self.classMask}, '
        'flags: ${self.flags}, '
        'minLevel: ${self.minLevel}, '
        'skillTierId: ${self.skillTierId}, '
        'skillCostIndex: ${self.skillCostIndex}'
        ')';
  }

  static SkillRaceClassInfoEntity fromJson(Map<String, dynamic> json) {
    return SkillRaceClassInfoEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      skillId: json['SkillID'] == true
          ? 1
          : json['SkillID'] == false
          ? 0
          : (json['SkillID'] as num?)?.toInt() ?? 0,
      raceMask: json['RaceMask'] == true
          ? 1
          : json['RaceMask'] == false
          ? 0
          : (json['RaceMask'] as num?)?.toInt() ?? 0,
      classMask: json['ClassMask'] == true
          ? 1
          : json['ClassMask'] == false
          ? 0
          : (json['ClassMask'] as num?)?.toInt() ?? 0,
      flags: json['Flags'] == true
          ? 1
          : json['Flags'] == false
          ? 0
          : (json['Flags'] as num?)?.toInt() ?? 0,
      minLevel: json['MinLevel'] == true
          ? 1
          : json['MinLevel'] == false
          ? 0
          : (json['MinLevel'] as num?)?.toInt() ?? 0,
      skillTierId: json['SkillTierID'] == true
          ? 1
          : json['SkillTierID'] == false
          ? 0
          : (json['SkillTierID'] as num?)?.toInt() ?? 0,
      skillCostIndex: json['SkillCostIndex'] == true
          ? 1
          : json['SkillCostIndex'] == false
          ? 0
          : (json['SkillCostIndex'] as num?)?.toInt() ?? 0,
    );
  }
}
