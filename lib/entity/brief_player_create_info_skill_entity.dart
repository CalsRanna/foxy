import 'package:foxy/entity/player_create_info_skill_key.dart';

class BriefPlayerCreateInfoSkillEntity {
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

  factory BriefPlayerCreateInfoSkillEntity.fromJson(
    Map<String, dynamic> json,
  ) => BriefPlayerCreateInfoSkillEntity(
    raceMask: json['raceMask'] ?? 0,
    classMask: json['classMask'] ?? 0,
    skill: json['skill'] ?? 0,
    rank: json['rank'] ?? 0,
    comment: json['comment'] ?? '',
  );

  PlayerCreateInfoSkillKey get key => PlayerCreateInfoSkillKey(
    raceMask: raceMask,
    classMask: classMask,
    skill: skill,
  );
}
