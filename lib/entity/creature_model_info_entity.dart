class CreatureModelInfoEntity {
  final int displayId;
  final double boundingRadius;
  final double combatReach;
  final int gender;
  final int displayIdOtherGender;

  const CreatureModelInfoEntity({
    this.displayId = 0,
    this.boundingRadius = 0.0,
    this.combatReach = 0.0,
    this.gender = 0,
    this.displayIdOtherGender = 0,
  });

  factory CreatureModelInfoEntity.fromJson(Map<String, dynamic> json) {
    return CreatureModelInfoEntity(
      displayId: json['DisplayID'] ?? 0,
      boundingRadius: (json['BoundingRadius'] ?? 0).toDouble(),
      combatReach: (json['CombatReach'] ?? 0).toDouble(),
      gender: json['Gender'] ?? 0,
      displayIdOtherGender: json['DisplayID_Other_Gender'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DisplayID': displayId,
      'BoundingRadius': boundingRadius,
      'CombatReach': combatReach,
      'Gender': gender,
      'DisplayID_Other_Gender': displayIdOtherGender,
    };
  }
}
