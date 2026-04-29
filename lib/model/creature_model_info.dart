class CreatureModelInfo {
  int displayId = 0;
  double boundingRadius = 0.0;
  double combatReach = 0.0;
  int gender = 0;
  int displayIdOtherGender = 0;

  CreatureModelInfo();

  factory CreatureModelInfo.fromJson(Map<String, dynamic> json) {
    return CreatureModelInfo()
      ..displayId = json['DisplayID'] ?? 0
      ..boundingRadius = (json['BoundingRadius'] ?? 0).toDouble()
      ..combatReach = (json['CombatReach'] ?? 0).toDouble()
      ..gender = json['Gender'] ?? 0
      ..displayIdOtherGender = json['DisplayID_Other_Gender'] ?? 0;
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
