import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_quest_offer_reward_entity.dart';
import 'package:foxy/entity/brief_quest_request_items_entity.dart';
import 'package:foxy/entity/brief_quest_template_addon_entity.dart';
import 'package:foxy/entity/quest_offer_reward_entity.dart';
import 'package:foxy/entity/quest_offer_reward_key.dart';
import 'package:foxy/entity/quest_request_items_entity.dart';
import 'package:foxy/entity/quest_request_items_key.dart';
import 'package:foxy/entity/quest_template_addon_entity.dart';
import 'package:foxy/entity/quest_template_addon_key.dart';

void main() {
  test('三张任务子表的 Key 和 Brief 精确暴露单列定位器', () {
    const addonKey = QuestTemplateAddonKey(id: 11);
    const requestKey = QuestRequestItemsKey(id: 12);
    const rewardKey = QuestOfferRewardKey(id: 13);

    expect(
      addonKey,
      QuestTemplateAddonKey.fromEntity(const QuestTemplateAddonEntity(id: 11)),
    );
    expect(
      requestKey,
      QuestRequestItemsKey.fromEntity(const QuestRequestItemsEntity(id: 12)),
    );
    expect(
      rewardKey,
      QuestOfferRewardKey.fromEntity(const QuestOfferRewardEntity(id: 13)),
    );
    expect(const BriefQuestTemplateAddonEntity(id: 11).key, addonKey);
    expect(const BriefQuestRequestItemsEntity(id: 12).key, requestKey);
    expect(const BriefQuestOfferRewardEntity(id: 13).key, rewardKey);
  });

  test('三张任务子表按原 typed key 更新完整 candidate 并检查写入结果', () {
    for (final stem in [
      'quest_template_addon',
      'quest_request_items',
      'quest_offer_reward',
    ]) {
      final source = File(
        'lib/repository/${stem}_repository.dart',
      ).readAsStringSync();
      expect(source, contains('originalKey'));
      expect(source, contains('.update(model.toJson())'));
      expect(source, contains('if (matchedRows == 0)'));
      expect(source, contains('if (deletedRows == 0)'));
      expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
      expect(source, isNot(contains('saveQuest')));
      expect(source, isNot(contains("json.remove('ID')")));
    }
  });

  test('子编辑器使用 editingKey，ID 可编辑且 locale 不绑定未保存 candidate', () {
    for (final stem in [
      'quest_template_addon',
      'quest_request_items',
      'quest_offer_reward',
    ]) {
      final viewModel = File(
        'lib/page/quest/${stem}_view_model.dart',
      ).readAsStringSync();
      final view = File('lib/page/quest/${stem}_view.dart').readAsStringSync();
      expect(viewModel, contains('editingKey = signal<'));
      expect(viewModel, contains('final originalKey = editingKey.value'));
      expect(viewModel, contains('id: idController.collect()'));
      expect(view, isNot(contains('readOnly: true')));
    }

    final requestView = File(
      'lib/page/quest/quest_request_items_view.dart',
    ).readAsStringSync();
    final rewardView = File(
      'lib/page/quest/quest_offer_reward_view.dart',
    ).readAsStringSync();
    expect(requestView, contains('entry: vm.editingKey.value?.id'));
    expect(rewardView, contains('entry: vm.editingKey.value?.id'));
  });

  test('三张独立 Brief 不暴露候选写入 API', () {
    for (final stem in [
      'brief_quest_template_addon_entity',
      'brief_quest_request_items_entity',
      'brief_quest_offer_reward_entity',
    ]) {
      final source = File('lib/entity/$stem.dart').readAsStringSync();
      expect(source, isNot(contains('toJson(')));
      expect(source, isNot(contains('copyWith(')));
    }
  });
}
