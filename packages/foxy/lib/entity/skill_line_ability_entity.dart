import 'package:foxy_annotation/entity_annotations.dart';

part 'skill_line_ability_entity.g.dart';

/// SkillLineAbility — links spells to a skill line (recipes, training)
@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_skill_line_ability')
class SkillLineAbilityEntity with _SkillLineAbilityEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('SkillLine', key: true)
  final int skillLine;

  @FoxyBriefField()
  @FoxyFullField('Spell')
  final int spell;

  @FoxyFullField('RaceMask')
  final int raceMask;

  @FoxyFullField('ClassMask')
  final int classMask;

  @FoxyFullField('ExcludeRace')
  final int excludeRace;

  @FoxyFullField('ExcludeClass')
  final int excludeClass;

  @FoxyFullField('MinSkillLineRank')
  final int minSkillLineRank;

  @FoxyFullField('SupercededBySpell')
  final int supercededBySpell;

  @FoxyFullField('AcquireMethod')
  final int acquireMethod;

  @FoxyFullField('TrivialSkillLineRankHigh')
  final int trivialSkillLineRankHigh;

  @FoxyFullField('TrivialSkillLineRankLow')
  final int trivialSkillLineRankLow;

  @FoxyFullField('CharacterPoints0')
  final int characterPoints0;

  @FoxyFullField('CharacterPoints1')
  final int characterPoints1;

  const SkillLineAbilityEntity({
    this.id = 0,
    this.skillLine = 0,
    this.spell = 0,
    this.raceMask = 0,
    this.classMask = 0,
    this.excludeRace = 0,
    this.excludeClass = 0,
    this.minSkillLineRank = 0,
    this.supercededBySpell = 0,
    this.acquireMethod = 0,
    this.trivialSkillLineRankHigh = 0,
    this.trivialSkillLineRankLow = 0,
    this.characterPoints0 = 0,
    this.characterPoints1 = 0,
  });

  factory SkillLineAbilityEntity.fromJson(Map<String, dynamic> json) =>
      _SkillLineAbilityEntityMixin.fromJson(json);
}
