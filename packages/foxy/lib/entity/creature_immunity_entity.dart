import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';
import 'package:foxy_game_definition/foxy_game_definition.dart';

part 'creature_immunity_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'creature_immunities')
class CreatureImmunityEntity with _CreatureImmunityEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFieldMeaning.flags('法术学派掩码', flags: SpellFlags.spellSchoolMaskOptions)
  @FoxyFullField('SchoolMask')
  final int schoolMask;

  @FoxyFullField('DispelTypeMask')
  final int dispelTypeMask;

  @FoxyBriefField()
  @FoxyFieldMeaning.flags(
    '机制免疫掩码',
    flags: CreatureFlags.mechanicImmuneMaskOptions,
  )
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
