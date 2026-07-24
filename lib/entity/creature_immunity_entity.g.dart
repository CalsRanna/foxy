// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_immunity_entity.dart';

mixin _CreatureImmunityEntityMixin {
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
    final self = this as CreatureImmunityEntity;
    return CreatureImmunityEntity(
      id: id ?? self.id,
      schoolMask: schoolMask ?? self.schoolMask,
      dispelTypeMask: dispelTypeMask ?? self.dispelTypeMask,
      mechanicsMask: mechanicsMask ?? self.mechanicsMask,
      effects: effects ?? self.effects,
      auras: auras ?? self.auras,
      immuneAoE: immuneAoE ?? self.immuneAoE,
      immuneChain: immuneChain ?? self.immuneChain,
      comment: comment ?? self.comment,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CreatureImmunityEntity;
    return {
      'ID': self.id,
      'SchoolMask': self.schoolMask,
      'DispelTypeMask': self.dispelTypeMask,
      'MechanicsMask': self.mechanicsMask,
      'Effects': self.effects,
      'Auras': self.auras,
      'ImmuneAoE': self.immuneAoE,
      'ImmuneChain': self.immuneChain,
      'Comment': self.comment,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as CreatureImmunityEntity;
    return identical(self, other) ||
        other is CreatureImmunityEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.schoolMask == other.schoolMask &&
            self.dispelTypeMask == other.dispelTypeMask &&
            self.mechanicsMask == other.mechanicsMask &&
            self.effects == other.effects &&
            self.auras == other.auras &&
            self.immuneAoE == other.immuneAoE &&
            self.immuneChain == other.immuneChain &&
            self.comment == other.comment;
  }

  @override
  int get hashCode {
    final self = this as CreatureImmunityEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.schoolMask,
      self.dispelTypeMask,
      self.mechanicsMask,
      self.effects,
      self.auras,
      self.immuneAoE,
      self.immuneChain,
      self.comment,
    ]);
  }

  @override
  String toString() {
    final self = this as CreatureImmunityEntity;
    return 'CreatureImmunityEntity('
        'id: ${self.id}, '
        'schoolMask: ${self.schoolMask}, '
        'dispelTypeMask: ${self.dispelTypeMask}, '
        'mechanicsMask: ${self.mechanicsMask}, '
        'effects: ${self.effects}, '
        'auras: ${self.auras}, '
        'immuneAoE: ${self.immuneAoE}, '
        'immuneChain: ${self.immuneChain}, '
        'comment: ${self.comment}'
        ')';
  }
}

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
