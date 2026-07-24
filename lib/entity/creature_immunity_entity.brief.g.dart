// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefCreatureImmunityEntity {
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
      id: (json['ID'] as num?)?.toInt() ?? 0,
      schoolMask: (json['SchoolMask'] as num?)?.toInt() ?? 0,
      mechanicsMask: (json['MechanicsMask'] as num?)?.toInt() ?? 0,
      immuneAoE: (json['ImmuneAoE'] as num?)?.toInt() ?? 0,
      immuneChain: (json['ImmuneChain'] as num?)?.toInt() ?? 0,
      comment: json['Comment']?.toString() ?? '',
    );
  }

  int get key => id;
}
