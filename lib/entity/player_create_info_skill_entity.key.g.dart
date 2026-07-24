// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'player_create_info_skill_entity.dart';

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
  ) {
    return PlayerCreateInfoSkillKey(
      raceMask: entity.raceMask,
      classMask: entity.classMask,
      skill: entity.skill,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlayerCreateInfoSkillKey &&
            raceMask == other.raceMask &&
            classMask == other.classMask &&
            skill == other.skill;
  }

  @override
  int get hashCode => Object.hashAll([raceMask, classMask, skill]);

  @override
  String toString() {
    return 'PlayerCreateInfoSkillKey('
        'raceMask: $raceMask, '
        'classMask: $classMask, '
        'skill: $skill'
        ')';
  }
}
