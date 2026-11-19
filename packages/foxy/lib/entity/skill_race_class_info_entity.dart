import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';
import 'package:foxy_game_definition/foxy_game_definition.dart';

part 'skill_race_class_info_entity.g.dart';

/// SkillRaceClassInfo — race/class restrictions and tier reference per skill
@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_skill_race_class_info')
class SkillRaceClassInfoEntity with _SkillRaceClassInfoEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFieldMeaning.reference('技能', table: 'foxy.dbc_skill_line', column: 'ID')
  @FoxyFullField('SkillID')
  final int skillId;

  @FoxyFieldMeaning.flags(
    '种族掩码',
    flags: PlayerCreateInfoConstants.playerCreateRaceMaskFlags,
  )
  @FoxyFullField('RaceMask')
  final int raceMask;

  @FoxyFieldMeaning.flags(
    '职业掩码',
    flags: PlayerCreateInfoConstants.playerCreateClassMaskFlags,
  )
  @FoxyFullField('ClassMask')
  final int classMask;

  @FoxyFullField('Flags')
  final int flags;

  @FoxyFullField('MinLevel')
  final int minLevel;

  @FoxyFieldMeaning.reference(
    '技能等级',
    table: 'foxy.dbc_skill_tiers',
    column: 'ID',
  )
  @FoxyFullField('SkillTierID')
  final int skillTierId;

  @FoxyFullField('SkillCostIndex')
  final int skillCostIndex;

  const SkillRaceClassInfoEntity({
    this.id = 0,
    this.skillId = 0,
    this.raceMask = 0,
    this.classMask = 0,
    this.flags = 0,
    this.minLevel = 0,
    this.skillTierId = 0,
    this.skillCostIndex = 0,
  });

  factory SkillRaceClassInfoEntity.fromJson(Map<String, dynamic> json) =>
      _SkillRaceClassInfoEntityMixin.fromJson(json);
}
