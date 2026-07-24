import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/quest_offer_reward_locale_entity.dart';
import './support/local_dart_library_source.dart';

void main() {
  test('Key 与 Brief 完整覆盖 ID + locale', () {
    const first = QuestOfferRewardLocaleKey(id: 7, locale: 'zhCN');
    const same = QuestOfferRewardLocaleKey(id: 7, locale: 'zhCN');
    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(
      first,
      isNot(const QuestOfferRewardLocaleKey(id: 8, locale: 'zhCN')),
    );
    expect(
      first,
      isNot(const QuestOfferRewardLocaleKey(id: 7, locale: 'deDE')),
    );

    final brief = BriefQuestOfferRewardLocaleEntity.fromJson({
      'ID': 7,
      'locale': 'zhCN',
      'RewardText': '奖励文本',
    });
    expect(brief.key, first);
    expect(brief.rewardText, '奖励文本');
    expect(
      File('lib/entity/quest_offer_reward_entity.dart').readAsStringSync(),
      isNot(contains('class BriefQuestOfferRewardLocaleEntity')),
    );
  });

  test('Repository uses original key, full candidate, and affected rows', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/quest_offer_reward_locale_repository.dart',
    );
    expect(source, contains("{'ID', 'locale'}"));
    expect(source, contains('QuestOfferRewardLocaleKey originalKey'));
    expect(source, contains(').update(json)'));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveQuestOfferRewardLocale(')));
    expect(source, isNot(contains('saveQuestOfferRewardLocales(')));
  });

  test('Editor loads Brief and preserves hidden fields from original row', () {
    final source = File(
      'lib/widget/foxy_locale_picker_delegates.dart',
    ).readAsStringSync();
    expect(source, contains('getBriefQuestOfferRewardLocales(id: entry)'));
    expect(source, contains('countQuestOfferRewardLocales(id: entry)'));
    expect(source, contains('getQuestOfferRewardLocale(brief.key)'));
    expect(source, contains('QuestOfferRewardLocaleKey('));
    expect(source, contains('updates[originalKey] = existing.copyWith('));
    expect(source, contains('applyQuestOfferRewardLocaleChanges('));
    expect(source, isNot(contains('getQuestOfferRewardLocales(entry)')));
  });
}
