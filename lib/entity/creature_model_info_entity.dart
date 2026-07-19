class CreatureModelInfoEntity {
  final int displayId;
  final double boundingRadius;
  final double combatReach;
  final int gender;
  final int displayIdOtherGender;
  final int verifiedBuild;

  const CreatureModelInfoEntity({
    this.displayId = 0,
    this.boundingRadius = 0.0,
    this.combatReach = 0.0,
    this.gender = 0,
    this.displayIdOtherGender = 0,
    this.verifiedBuild = 0,
  });

  factory CreatureModelInfoEntity.fromJson(Map<String, dynamic> json) {
    return CreatureModelInfoEntity(
      displayId: json['DisplayID'] ?? 0,
      boundingRadius: (json['BoundingRadius'] ?? 0.0),
      combatReach: (json['CombatReach'] ?? 0.0),
      gender: json['Gender'] ?? 0,
      displayIdOtherGender: json['DisplayID_Other_Gender'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? 0,
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
}
