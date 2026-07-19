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

  int get key => id;
}
