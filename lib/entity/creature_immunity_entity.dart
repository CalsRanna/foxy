class BriefCreatureImmunityEntity {
  final int id;
  final int schoolMask;
  final int mechanicsMask;
  final int immuneAoE;
  final int immuneChain;
  final String comment;

  const BriefCreatureImmunityEntity({
    this.id = 0,
    this.schoolMask = 0,
    this.mechanicsMask = 0,
    this.immuneAoE = 0,
    this.immuneChain = 0,
    this.comment = '',
  });

  factory BriefCreatureImmunityEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureImmunityEntity(
      id: json['ID'] ?? 0,
      schoolMask: json['SchoolMask'] ?? 0,
      mechanicsMask: json['MechanicsMask'] ?? 0,
      immuneAoE: json['ImmuneAoE'] ?? 0,
      immuneChain: json['ImmuneChain'] ?? 0,
      comment: json['Comment'] ?? '',
    );
  }
}

class CreatureImmunityEntity {
  final int id;
  final int schoolMask;
  final int dispelTypeMask;
  final int mechanicsMask;
  final String effects;
  final String auras;
  final int immuneAoE;
  final int immuneChain;
  final String comment;

  const CreatureImmunityEntity({
    this.id = 0,
    this.schoolMask = 0,
    this.dispelTypeMask = 0,
    this.mechanicsMask = 0,
    this.effects = '',
    this.auras = '',
    this.immuneAoE = 0,
    this.immuneChain = 0,
    this.comment = '',
  });

  factory CreatureImmunityEntity.fromJson(Map<String, dynamic> json) {
    return CreatureImmunityEntity(
      id: json['ID'] ?? 0,
      schoolMask: json['SchoolMask'] ?? 0,
      dispelTypeMask: json['DispelTypeMask'] ?? 0,
      mechanicsMask: json['MechanicsMask'] ?? 0,
      effects: json['Effects'] ?? '',
      auras: json['Auras'] ?? '',
      immuneAoE: json['ImmuneAoE'] ?? 0,
      immuneChain: json['ImmuneChain'] ?? 0,
      comment: json['Comment'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'SchoolMask': schoolMask,
      'DispelTypeMask': dispelTypeMask,
      'MechanicsMask': mechanicsMask,
      'Effects': effects,
      'Auras': auras,
      'ImmuneAoE': immuneAoE,
      'ImmuneChain': immuneChain,
      'Comment': comment,
    };
  }
}
