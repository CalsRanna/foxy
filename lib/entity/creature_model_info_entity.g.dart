// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_model_info_entity.dart';

mixin _CreatureModelInfoEntityMixin {
  static CreatureModelInfoEntity fromJson(Map<String, dynamic> json) {
    return CreatureModelInfoEntity(
      displayId: (json['DisplayID'] as num?)?.toInt() ?? 0,
      boundingRadius: (json['BoundingRadius'] as num?)?.toDouble() ?? 0.0,
      combatReach: (json['CombatReach'] as num?)?.toDouble() ?? 0.0,
      gender: (json['Gender'] as num?)?.toInt() ?? 0,
      displayIdOtherGender:
          (json['DisplayID_Other_Gender'] as num?)?.toInt() ?? 0,
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  CreatureModelInfoEntity copyWith({
    int? displayId,
    double? boundingRadius,
    double? combatReach,
    int? gender,
    int? displayIdOtherGender,
    int? verifiedBuild,
  }) {
    final self = this as CreatureModelInfoEntity;
    return CreatureModelInfoEntity(
      displayId: displayId ?? self.displayId,
      boundingRadius: boundingRadius ?? self.boundingRadius,
      combatReach: combatReach ?? self.combatReach,
      gender: gender ?? self.gender,
      displayIdOtherGender: displayIdOtherGender ?? self.displayIdOtherGender,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CreatureModelInfoEntity;
    return {
      'DisplayID': self.displayId,
      'BoundingRadius': self.boundingRadius,
      'CombatReach': self.combatReach,
      'Gender': self.gender,
      'DisplayID_Other_Gender': self.displayIdOtherGender,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as CreatureModelInfoEntity;
    return identical(self, other) ||
        other is CreatureModelInfoEntity &&
            self.runtimeType == other.runtimeType &&
            self.displayId == other.displayId &&
            self.boundingRadius == other.boundingRadius &&
            self.combatReach == other.combatReach &&
            self.gender == other.gender &&
            self.displayIdOtherGender == other.displayIdOtherGender &&
            self.verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    final self = this as CreatureModelInfoEntity;
    return Object.hashAll([
      self.runtimeType,
      self.displayId,
      self.boundingRadius,
      self.combatReach,
      self.gender,
      self.displayIdOtherGender,
      self.verifiedBuild,
    ]);
  }

  @override
  String toString() {
    final self = this as CreatureModelInfoEntity;
    return 'CreatureModelInfoEntity('
        'displayId: ${self.displayId}, '
        'boundingRadius: ${self.boundingRadius}, '
        'combatReach: ${self.combatReach}, '
        'gender: ${self.gender}, '
        'displayIdOtherGender: ${self.displayIdOtherGender}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }
}

final class BriefCreatureModelInfoEntity {
  final int displayId;
  final double boundingRadius;
  final double combatReach;
  final int gender;
  final int displayIdOtherGender;

  const BriefCreatureModelInfoEntity({
    this.displayId = 0,
    this.boundingRadius = 0.0,
    this.combatReach = 0.0,
    this.gender = 0,
    this.displayIdOtherGender = 0,
  });

  factory BriefCreatureModelInfoEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureModelInfoEntity(
      displayId: (json['DisplayID'] as num?)?.toInt() ?? 0,
      boundingRadius: (json['BoundingRadius'] as num?)?.toDouble() ?? 0.0,
      combatReach: (json['CombatReach'] as num?)?.toDouble() ?? 0.0,
      gender: (json['Gender'] as num?)?.toInt() ?? 0,
      displayIdOtherGender:
          (json['DisplayID_Other_Gender'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => displayId;
}
