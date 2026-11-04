import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:test/test.dart';

void main() {
  test('QuestType 使用 Method 值域而不是 QuestTypes 枚举', () {
    expect(QuestEnums.questMethodOptions.keys, orderedEquals([0, 1, 2]));
    expect(QuestEnums.questMethodOptions, isNot(contains(41)));
    expect(
      QuestEnums.questRewardDifficultyOptions.keys,
      orderedEquals(List.generate(10, (i) => i)),
    );
  });

  test('Flags 仅包含 3.3.5a 定义位，SpecialFlags 排除运行时位', () {
    final questMask = QuestFlags.questFlagOptions.fold(
      0,
      (mask, flag) => mask | flag.value,
    );
    final specialMask = QuestFlags.questSpecialFlagOptions.fold(
      0,
      (mask, flag) => mask | flag.value,
    );
    expect(questMask, QuestFlags.questFlagsAllowedMask);
    expect(specialMask, QuestFlags.questSpecialFlagsAllowedMask);
    expect(specialMask & 0x3E00, 0);
  });
}
