import 'package:foxy_annotation/entity_annotations.dart';

part 'creature_template_resistance_entity.g.dart';

/// Creature template resistances

@FoxyBriefEntity()
@FoxyFullEntity()
class CreatureTemplateResistanceEntity
    with _CreatureTemplateResistanceEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('CreatureID', key: true)
  final int creatureID;

  @FoxyBriefField()
  @FoxyFullField('School', key: true)
  final int school;

  @FoxyBriefField()
  @FoxyFullField('Resistance')
  final int resistance;

  @FoxyBriefField()
  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const CreatureTemplateResistanceEntity({
    this.creatureID = 0,
    this.school = 0,
    this.resistance = 0,
    this.verifiedBuild = 0,
  });

  factory CreatureTemplateResistanceEntity.fromJson(
    Map<String, dynamic> json,
  ) => _CreatureTemplateResistanceEntityMixin.fromJson(json);
}
