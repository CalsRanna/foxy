import 'package:flutter_test/flutter_test.dart';
import 'support/entity_validation_test_extensions.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/entity/quest_faction_reward_entity.dart';

void main() {
  test('QuestFactionReward Entity 精确覆盖 11 个物理列且全部为标量', () {
    final json = const QuestFactionRewardEntity().toJson();
    expect(json.keys.toList(), [
      'ID',
      'Difficulty0',
      'Difficulty1',
      'Difficulty2',
      'Difficulty3',
      'Difficulty4',
      'Difficulty5',
      'Difficulty6',
      'Difficulty7',
      'Difficulty8',
      'Difficulty9',
    ]);
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
    expect(
      dbcDefinitionByTable['dbc_quest_faction_reward']?.fileName,
      'QuestFactionReward.dbc',
    );
  });

  test('官方正向和负向奖励记录通过校验', () {
    const positive = QuestFactionRewardEntity(
      id: 1,
      difficulty0: 0,
      difficulty1: 10,
      difficulty2: 25,
      difficulty3: 75,
      difficulty4: 150,
      difficulty5: 250,
      difficulty6: 350,
      difficulty7: 500,
      difficulty8: 1000,
      difficulty9: 5,
    );
    const negative = QuestFactionRewardEntity(
      id: 2,
      difficulty0: 0,
      difficulty1: -10,
      difficulty2: -25,
      difficulty3: -75,
      difficulty4: -150,
      difficulty5: -250,
      difficulty6: -350,
      difficulty7: -500,
      difficulty8: -1000,
      difficulty9: -5,
    );
    expect(positive.validate, returnsNormally);
    expect(negative.validate, returnsNormally);
  });

  test('固定 ID、正负方向和 signed int32 约束拒绝非法记录', () {
    expect(
      () => const QuestFactionRewardEntity(id: 3).validate(),
      throwsStateError,
    );
    expect(
      () => const QuestFactionRewardEntity(id: 1, difficulty1: -1).validate(),
      throwsStateError,
    );
    expect(
      () => const QuestFactionRewardEntity(id: 2, difficulty1: 1).validate(),
      throwsStateError,
    );
    expect(
      () => const QuestFactionRewardEntity(
        id: 1,
        difficulty1: 2147483648,
      ).validate(),
      throwsStateError,
    );
  });
}
