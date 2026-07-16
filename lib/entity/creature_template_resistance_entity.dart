/// 生物模板抗性
class CreatureTemplateResistanceEntity {
  final int creatureID;
  final int school;
  final int resistance;
  final int verifiedBuild;

  const CreatureTemplateResistanceEntity({
    this.creatureID = 0,
    this.school = 0,
    this.resistance = 0,
    this.verifiedBuild = 0,
  });

  factory CreatureTemplateResistanceEntity.fromJson(Map<String, dynamic> json) {
    return CreatureTemplateResistanceEntity(
      creatureID: json['CreatureID'] ?? json['creatureID'] ?? 0,
      school: json['School'] ?? json['school'] ?? 0,
      resistance: json['Resistance'] ?? json['resistance'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? json['verifiedBuild'] ?? 0,
    );
  }

  CreatureTemplateResistanceEntity copyWith({
    int? creatureID,
    int? school,
    int? resistance,
    int? verifiedBuild,
  }) {
    return CreatureTemplateResistanceEntity(
      creatureID: creatureID ?? this.creatureID,
      school: school ?? this.school,
      resistance: resistance ?? this.resistance,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
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
