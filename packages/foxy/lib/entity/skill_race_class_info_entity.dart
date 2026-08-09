import 'package:foxy_annotation/entity_annotations.dart';

part 'skill_race_class_info_entity.g.dart';

/// SkillRaceClassInfo — race/class restrictions and tier reference per skill
@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_skill_race_class_info')
class SkillRaceClassInfoEntity with _SkillRaceClassInfoEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('SkillID')
  final int skillId;

  @FoxyFullField('RaceMask')
  final int raceMask;

  @FoxyFullField('ClassMask')
  final int classMask;

  @FoxyFullField('Flags')
  final int flags;

  @FoxyFullField('MinLevel')
  final int minLevel;

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
