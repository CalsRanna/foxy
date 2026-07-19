class BriefCreatureModelInfoEntity {
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
      displayId: json['DisplayID'] ?? 0,
      boundingRadius: (json['BoundingRadius'] as num?)?.toDouble() ?? 0.0,
      combatReach: (json['CombatReach'] as num?)?.toDouble() ?? 0.0,
      gender: json['Gender'] ?? 0,
      displayIdOtherGender: json['DisplayID_Other_Gender'] ?? 0,
    );
  }

  int get key => displayId;
}
