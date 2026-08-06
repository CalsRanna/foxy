import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/quest_enums.dart';
import 'package:foxy/constant/quest_flags.dart';
import 'package:foxy/entity/creature_quest_ender_entity.dart';
import 'package:foxy/entity/creature_quest_starter_entity.dart';
import 'package:foxy/entity/game_object_quest_ender_entity.dart';
import 'package:foxy/entity/game_object_quest_starter_entity.dart';

void main() {

  test('四张起止关系表都使用显式复合键字段', () {
    expect(const CreatureQuestStarterEntity().toJson().keys.toSet(), {
      'id',
      'quest',
    });
    expect(const CreatureQuestEnderEntity().toJson().keys.toSet(), {
      'id',
      'quest',
    });
    expect(const GameObjectQuestStarterEntity().toJson().keys.toSet(), {
      'id',
      'quest',
    });
    expect(const GameObjectQuestEnderEntity().toJson().keys.toSet(), {
      'id',
      'quest',
    });
  });

  test('QuestType 使用 Method 值域而不是 QuestTypes 枚举', () {
    expect(kQuestMethodOptions.keys, orderedEquals([0, 1, 2]));
    expect(kQuestMethodOptions, isNot(contains(41)));
    expect(
      kQuestRewardDifficultyOptions.keys,
      orderedEquals(List.generate(10, (i) => i)),
    );
  });

  test('Flags 仅包含 3.3.5a 定义位，SpecialFlags 排除运行时位', () {
    final questMask = kQuestFlagOptions.fold(
      0,
      (mask, flag) => mask | flag.value,
    );
    final specialMask = kQuestSpecialFlagOptions.fold(
      0,
      (mask, flag) => mask | flag.value,
    );
    expect(questMask, kQuestFlagsAllowedMask);
    expect(specialMask, kQuestSpecialFlagsAllowedMask);
    expect(specialMask & 0x3E00, 0);
  });

}
