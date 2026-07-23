import 'support/entity_validation_test_extensions.dart';
import 'dart:io';

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

  test('Repository 预分配固定 ID 并使用原始键写入当前表', () {
    final source = File(
      'lib/repository/quest_faction_reward_repository.dart',
    ).readAsStringSync();
    expect(source, contains('1'));
    expect(source, contains('2'));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(questFactionReward.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, isNot(contains('nextMaxPlusOne')));
    expect(source, isNot(contains('.validate()')));
  });

  test('详情页显式管理十个奖励值并保持每行四列等宽', () {
    final view = File(
      'lib/page/quest_faction_reward/quest_faction_reward_view.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/quest_faction_reward/quest_faction_reward_detail_view_model.dart',
    ).readAsStringSync();
    for (var index = 0; index < 10; index++) {
      expect(view, contains("label: '索引 $index 声望值'"));
      expect(view, contains('viewModel.difficulty${index}Controller'));
      expect(viewModel, contains('difficulty${index}Controller'));
    }
    expect(view, isNot(contains('List.generate')));
    expect(view, isNot(contains('for (')));
    expect(view, isNot(contains('flex:')));
    expect('Expanded(child:'.allMatches(view), hasLength(16));
    expect(viewModel, isNot(contains('List.generate')));
    expect(viewModel, contains('validateQuestFactionRewardFields(candidate)'));
    expect(viewModel, contains('signal<int?>(null)'));
    expect(viewModel, contains('final originalKey = persistedKey.value'));
    expect(
      viewModel,
      contains('updateQuestFactionReward(originalKey, candidate)'),
    );
    expect(viewModel, contains('persistedKey.value = candidate.id'));
    expect(view, isNot(contains('readOnly: true')));
  });

  test('列表允许编辑删除并仅在缺少固定记录时允许新增', () {
    final page = File(
      'lib/page/quest_faction_reward/quest_faction_reward_list_page.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/quest_faction_reward/quest_faction_reward_list_view_model.dart',
    ).readAsStringSync();
    expect(page, contains('reward.id == 1'));
    expect(page, contains('reward.id == 2'));
    expect(page, isNot(contains('LucideIcons.copy')));
    expect(page, contains('LucideIcons.trash'));
    expect(viewModel, isNot(contains('copyQuestFactionReward')));
    expect(viewModel, contains('Future<void> destroy(int key)'));
  });

  test('Entity 源码没有数组或 Map 字段', () {
    final source = File(
      'lib/entity/quest_faction_reward_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('final List<')));
    expect(source, isNot(contains('final Map<')));
  });
}
