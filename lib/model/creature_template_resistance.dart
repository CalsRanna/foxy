/// 生物模板抗性
class CreatureTemplateResistance {
  int creatureID = 0;
  int school = 0;
  int resistance = 0;
  int verifiedBuild = 0;

  CreatureTemplateResistance();

  CreatureTemplateResistance.fromJson(Map<String, dynamic> json) {
    creatureID = json['CreatureID'] ?? json['creatureID'] ?? 0;
    school = json['School'] ?? json['school'] ?? 0;
    resistance = json['Resistance'] ?? json['resistance'] ?? 0;
    verifiedBuild = json['VerifiedBuild'] ?? json['verifiedBuild'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'CreatureID': creatureID,
      'School': school,
      'Resistance': resistance,
      'VerifiedBuild': verifiedBuild,
    };
  }
}
