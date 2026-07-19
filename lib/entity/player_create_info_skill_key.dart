import 'package:foxy/entity/player_create_info_entity.dart';

final class PlayerCreateInfoSkillKey {
  final int raceMask;
  final int classMask;
  final int skill;

  const PlayerCreateInfoSkillKey({
    required this.raceMask,
    required this.classMask,
    required this.skill,
  });

  factory PlayerCreateInfoSkillKey.fromEntity(
    PlayerCreateInfoSkillEntity entity,
  ) => PlayerCreateInfoSkillKey(
    raceMask: entity.raceMask,
    classMask: entity.classMask,
    skill: entity.skill,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerCreateInfoSkillKey &&
          other.raceMask == raceMask &&
          other.classMask == classMask &&
          other.skill == skill;

  @override
  int get hashCode => Object.hash(raceMask, classMask, skill);
}
