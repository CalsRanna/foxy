// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_model_info_entity.dart';

mixin _CreatureModelInfoEntityMixin {
  int get displayId;
  double get boundingRadius;
  double get combatReach;
  int get gender;
  int get displayIdOtherGender;
  int get verifiedBuild;

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
    return CreatureModelInfoEntity(
      displayId: displayId ?? this.displayId,
      boundingRadius: boundingRadius ?? this.boundingRadius,
      combatReach: combatReach ?? this.combatReach,
      gender: gender ?? this.gender,
      displayIdOtherGender: displayIdOtherGender ?? this.displayIdOtherGender,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DisplayID': displayId,
      'BoundingRadius': boundingRadius,
      'CombatReach': combatReach,
      'Gender': gender,
      'DisplayID_Other_Gender': displayIdOtherGender,
      'VerifiedBuild': verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureModelInfoEntity &&
            runtimeType == other.runtimeType &&
            displayId == other.displayId &&
            boundingRadius == other.boundingRadius &&
            combatReach == other.combatReach &&
            gender == other.gender &&
            displayIdOtherGender == other.displayIdOtherGender &&
            verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      displayId,
      boundingRadius,
      combatReach,
      gender,
      displayIdOtherGender,
      verifiedBuild,
    ]);
  }

  @override
  String toString() {
    return 'CreatureModelInfoEntity('
        'displayId: $displayId, '
        'boundingRadius: $boundingRadius, '
        'combatReach: $combatReach, '
        'gender: $gender, '
        'displayIdOtherGender: $displayIdOtherGender, '
        'verifiedBuild: $verifiedBuild'
        ')';
  }
}
