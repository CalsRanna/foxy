import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/entity/player_create_info_skill_entity.dart';

void main() {

  test('种族职业 ID 与掩码分别对应 SharedDefines', () {
    expect(PlayerCreateInfoConstants.playerRaceOptions.keys.toList(), [1, 2, 3, 4, 5, 6, 7, 8, 10, 11]);
    expect(PlayerCreateInfoConstants.playerClassOptions.keys.toList(), [1, 2, 3, 4, 5, 6, 7, 8, 9, 11]);
    expect(PlayerCreateInfoConstants.playerCreateRaceMaskFlags.map((item) => item.value).toList(), [
      1, 2, 4, 8, 16, 32, 64, 128, 512, 1024,
    ]);
    expect(PlayerCreateInfoConstants.playerCreateClassMaskFlags.map((item) => item.value).toList(), [
      1, 2, 4, 8, 16, 32, 64, 128, 256, 1024,
    ]);
    expect(PlayerCreateInfoConstants.raceBit(10), 512);
    expect(PlayerCreateInfoConstants.classBit(11), 1024);
    expect(PlayerCreateInfoConstants.playerCreatePlayableRaceMask, 1791);
    expect(PlayerCreateInfoConstants.playerCreatePlayableClassMask, 1535);
  });

  test('动作类型只包含 Player ActionButtonType', () {
    expect(PlayerCreateInfoConstants.playerActionButtonTypeOptions.keys.toSet(), {0, 1, 32, 64, 65, 128});
  });

  test('种族/职业 ID 映射为标签，未知值回退', () {
    expect(const BriefPlayerCreateInfoEntity(race: 1, class_: 2).raceLabel, '人类');
    expect(const BriefPlayerCreateInfoEntity(race: 1, class_: 2).classLabel, '圣骑士');
    expect(const BriefPlayerCreateInfoEntity(race: 99).raceLabel, '99');
  });

  test('种族/职业掩码展开为标签，未命中回退', () {
    const skill = BriefPlayerCreateInfoSkillEntity(
      raceMask: 1 | 8,
      classMask: 1 | 4,
    );
    expect(skill.raceMaskLabel, '人类, 暗夜精灵');
    expect(skill.classMaskLabel, '战士, 猎人');
    expect(const BriefPlayerCreateInfoSkillEntity(raceMask: 0).raceMaskLabel, '0');
  });

}
