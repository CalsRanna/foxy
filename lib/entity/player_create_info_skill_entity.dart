import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

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
