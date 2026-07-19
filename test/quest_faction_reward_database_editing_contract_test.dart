import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_quest_faction_reward_entity.dart';
import 'package:foxy/entity/quest_faction_reward_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 1;
    expect((const QuestFactionRewardEntity(id: 1)).id, key);
    expect(const BriefQuestFactionRewardEntity(id: 1).key, key);
  });

  test('QuestFactionReward 路由只携带标量 key 且列表传 brief.key', () {
    final page = File(
      'lib/page/quest_faction_reward/quest_faction_reward_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/quest_faction_reward/quest_faction_reward_list_page.dart',
    ).readAsStringSync();
    expect(page, contains('final int? questFactionRewardKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('rewards[row].key'));
  });

  test('BriefQuestFactionReward 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_quest_faction_reward_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
