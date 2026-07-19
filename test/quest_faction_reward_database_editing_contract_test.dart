import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_quest_faction_reward_entity.dart';
import 'package:foxy/entity/quest_faction_reward_entity.dart';
import 'package:foxy/entity/quest_faction_reward_key.dart';

void main() {
  test('QuestFactionRewardKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = QuestFactionRewardKey(id: 1);
    expect(key, const QuestFactionRewardKey(id: 1));
    expect(key.hashCode, const QuestFactionRewardKey(id: 1).hashCode);
    expect(
      QuestFactionRewardKey.fromEntity(const QuestFactionRewardEntity(id: 1)),
      key,
    );
    expect(const BriefQuestFactionRewardEntity(id: 1).key, key);
  });

  test('QuestFactionReward 路由只携带 typed key 且列表传 brief.key', () {
    final page = File(
      'lib/page/quest_faction_reward/quest_faction_reward_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/quest_faction_reward/quest_faction_reward_list_page.dart',
    ).readAsStringSync();
    expect(
      page,
      contains('final QuestFactionRewardKey? questFactionRewardKey'),
    );
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
