// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'player_create_info_skill_entity.key.g.dart';

final class BriefPlayerCreateInfoSkillEntity {
  final int raceMask;
  final int classMask;
  final int skill;
  final int rank;
  final String comment;

  const BriefPlayerCreateInfoSkillEntity({
    this.raceMask = 0,
    this.classMask = 0,
    this.skill = 0,
    this.rank = 0,
    this.comment = '',
  });

  factory BriefPlayerCreateInfoSkillEntity.fromJson(Map<String, dynamic> json) {
    return BriefPlayerCreateInfoSkillEntity(
      raceMask: (json['raceMask'] as num?)?.toInt() ?? 0,
      classMask: (json['classMask'] as num?)?.toInt() ?? 0,
      skill: (json['skill'] as num?)?.toInt() ?? 0,
      rank: (json['rank'] as num?)?.toInt() ?? 0,
      comment: json['comment']?.toString() ?? '',
    );
  }

  PlayerCreateInfoSkillKey get key {
    return PlayerCreateInfoSkillKey(
      raceMask: raceMask,
      classMask: classMask,
      skill: skill,
    );
  }
}
