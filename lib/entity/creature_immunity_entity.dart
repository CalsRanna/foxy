// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'creature_immunity_entity.g.dart';

@FoxyBriefEntity()
@FoxyFilterEntity()
@FoxyFullEntity(table: 'creature_immunities')
class CreatureImmunityEntity with _CreatureImmunityEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('SchoolMask')
  final int schoolMask;

  @FoxyFullField('DispelTypeMask')
  final int dispelTypeMask;

  @FoxyBriefField()
  @FoxyFullField('MechanicsMask')
  final int mechanicsMask;

  @FoxyFullField('Effects')
  final String effects;

  @FoxyFullField('Auras')
  final String auras;

  @FoxyBriefField()
  @FoxyFullField('ImmuneAoE')
  final int immuneAoE;

  @FoxyBriefField()
  @FoxyFullField('ImmuneChain')
  final int immuneChain;

  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('Comment')
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

  factory CreatureImmunityEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureImmunityEntityMixin.fromJson(json);
}
