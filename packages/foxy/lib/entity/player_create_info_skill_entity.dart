import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_game_definition/foxy_game_definition.dart';

part 'player_create_info_skill_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('skillName')
@FoxyBriefField.text('textureFilename')
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
  /// Matching class labels, with the raw mask as a fallback.
  String get classMaskLabel => FlagItem.maskLabel(
    classMask,
    PlayerCreateInfoConstants.playerCreateClassMaskFlags,
  );

  /// Matching race labels, with the raw mask as a fallback.
  String get raceMaskLabel => FlagItem.maskLabel(
    raceMask,
    PlayerCreateInfoConstants.playerCreateRaceMaskFlags,
  );
}
