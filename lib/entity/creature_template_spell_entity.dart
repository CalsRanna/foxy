import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'creature_template_spell_entity.g.dart';

/// 生物模板技能

@FoxyBriefEntity()
@FoxyBriefField.text('spellName')
@FoxyBriefField.text('spellSubtext')
@FoxyFullEntity(table: 'creature_template_spell')
class CreatureTemplateSpellEntity with _CreatureTemplateSpellEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('CreatureID', key: true)
  final int creatureID;

  @FoxyBriefField()
  @FoxyFullField('Index', key: true)
  final int index;

  @FoxyBriefField()
  @FoxyFullField('Spell')
  final int spell;

  @FoxyBriefField()
  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const CreatureTemplateSpellEntity({
    this.creatureID = 0,
    this.index = 0,
    this.spell = 0,
    this.verifiedBuild = 0,
  });

  factory CreatureTemplateSpellEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureTemplateSpellEntityMixin.fromJson(json);
}

extension BriefCreatureTemplateSpellEntityDisplay
    on BriefCreatureTemplateSpellEntity {
  String get displayName =>
      spellSubtext.isNotEmpty ? '$spellName - $spellSubtext' : spellName;
}
