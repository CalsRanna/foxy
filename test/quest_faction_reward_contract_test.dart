import 'package:flutter_test/flutter_test.dart';
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

}
