import 'package:foxy/constant/flag_item.dart';
import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy_annotation/entity_annotations.dart';

part 'player_create_info_skill_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'playercreateinfo_skills')
class PlayerCreateInfoSkillEntity with _PlayerCreateInfoSkillEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('raceMask', key: true)
  final int raceMask;

  @FoxyBriefField()
  @FoxyFullField('classMask', key: true)
  final int classMask;

  @FoxyBriefField()
  @FoxyFullField('skill', key: true)
  final int skill;

  @FoxyBriefField()
  @FoxyFullField('rank')
  final int rank;

  @FoxyBriefField()
  @FoxyFullField('comment')
  final String comment;

  const PlayerCreateInfoSkillEntity({
    this.raceMask = 0,
    this.classMask = 0,
    this.skill = 0,
    this.rank = 0,
    this.comment = '',
  });

  factory PlayerCreateInfoSkillEntity.fromJson(Map<String, dynamic> json) =>
      _PlayerCreateInfoSkillEntityMixin.fromJson(json);
}

extension BriefPlayerCreateInfoSkillEntityLabel
    on BriefPlayerCreateInfoSkillEntity {
  /// 种族掩码标签（人类/兽人/…），未命中回退为原始掩码。
  String get raceMaskLabel =>
      flagMaskLabel(raceMask, kPlayerCreateRaceMaskFlags);

  /// 职业掩码标签（战士/圣骑士/…），未命中回退为原始掩码。
  String get classMaskLabel =>
      flagMaskLabel(classMask, kPlayerCreateClassMaskFlags);
}
