// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_immunity_entity.dart';

mixin _CreatureImmunityEntityMixin {
  int get id;
  int get schoolMask;
  int get dispelTypeMask;
  int get mechanicsMask;
  String get effects;
  String get auras;
  int get immuneAoE;
  int get immuneChain;
  String get comment;

  static CreatureImmunityEntity fromJson(Map<String, dynamic> json) {
    return CreatureImmunityEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      schoolMask: (json['SchoolMask'] as num?)?.toInt() ?? 0,
      dispelTypeMask: (json['DispelTypeMask'] as num?)?.toInt() ?? 0,
      mechanicsMask: (json['MechanicsMask'] as num?)?.toInt() ?? 0,
      effects: json['Effects']?.toString() ?? '',
      auras: json['Auras']?.toString() ?? '',
      immuneAoE: (json['ImmuneAoE'] as num?)?.toInt() ?? 0,
      immuneChain: (json['ImmuneChain'] as num?)?.toInt() ?? 0,
      comment: json['Comment']?.toString() ?? '',
    );
  }

  CreatureImmunityEntity copyWith({
    int? id,
    int? schoolMask,
    int? dispelTypeMask,
    int? mechanicsMask,
    String? effects,
    String? auras,
    int? immuneAoE,
    int? immuneChain,
    String? comment,
  }) {
    return CreatureImmunityEntity(
      id: id ?? this.id,
      schoolMask: schoolMask ?? this.schoolMask,
      dispelTypeMask: dispelTypeMask ?? this.dispelTypeMask,
      mechanicsMask: mechanicsMask ?? this.mechanicsMask,
      effects: effects ?? this.effects,
      auras: auras ?? this.auras,
      immuneAoE: immuneAoE ?? this.immuneAoE,
      immuneChain: immuneChain ?? this.immuneChain,
      comment: comment ?? this.comment,
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureImmunityEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            schoolMask == other.schoolMask &&
            dispelTypeMask == other.dispelTypeMask &&
            mechanicsMask == other.mechanicsMask &&
            effects == other.effects &&
            auras == other.auras &&
            immuneAoE == other.immuneAoE &&
            immuneChain == other.immuneChain &&
            comment == other.comment;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      schoolMask,
      dispelTypeMask,
      mechanicsMask,
      effects,
      auras,
      immuneAoE,
      immuneChain,
      comment,
    ]);
  }

  @override
  String toString() {
    return 'CreatureImmunityEntity('
        'id: $id, '
        'schoolMask: $schoolMask, '
        'dispelTypeMask: $dispelTypeMask, '
        'mechanicsMask: $mechanicsMask, '
        'effects: $effects, '
        'auras: $auras, '
        'immuneAoE: $immuneAoE, '
        'immuneChain: $immuneChain, '
        'comment: $comment'
        ')';
  }
}
