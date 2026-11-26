import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/entity/player_create_info_skill_entity.dart';

void main() {
  test('Race and class IDs map to labels and unknown values fall back', () {
    expect(
      const BriefPlayerCreateInfoEntity(race: 1, class_: 2).raceLabel,
      '人类',
    );
    expect(
      const BriefPlayerCreateInfoEntity(race: 1, class_: 2).classLabel,
      '圣骑士',
    );
    expect(const BriefPlayerCreateInfoEntity(race: 99).raceLabel, '99');
  });

  test(
    'Race and class masks expand to labels and unmatched values fall back',
    () {
      const skill = BriefPlayerCreateInfoSkillEntity(
        raceMask: 1 | 8,
        classMask: 1 | 4,
      );
      expect(skill.raceMaskLabel, '人类, 暗夜精灵');
      expect(skill.classMaskLabel, '战士, 猎人');
      expect(
        const BriefPlayerCreateInfoSkillEntity(raceMask: 0).raceMaskLabel,
        '0',
      );
    },
  );
}
