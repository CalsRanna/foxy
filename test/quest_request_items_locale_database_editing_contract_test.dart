import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_quest_request_items_locale_entity.dart';
import 'package:foxy/entity/quest_request_items_locale_key.dart';

void main() {
  test('Key 与 Brief 完整覆盖 ID + locale', () {
    const first = QuestRequestItemsLocaleKey(id: 9, locale: 'zhCN');
    const same = QuestRequestItemsLocaleKey(id: 9, locale: 'zhCN');
    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(
      first,
      isNot(const QuestRequestItemsLocaleKey(id: 10, locale: 'zhCN')),
    );
    expect(
      first,
      isNot(const QuestRequestItemsLocaleKey(id: 9, locale: 'deDE')),
    );

    final brief = BriefQuestRequestItemsLocaleEntity.fromJson({
      'ID': 9,
      'locale': 'zhCN',
      'CompletionText': '完成文本',
    });
    expect(brief.key, first);
    expect(brief.completionText, '完成文本');
    expect(
      File('lib/entity/quest_request_items_entity.dart').readAsStringSync(),
      isNot(contains('class BriefQuestRequestItemsLocaleEntity')),
    );
  });

  test('Repository uses original key, full candidate, and affected rows', () {
    final source = File(
      'lib/repository/quest_request_items_locale_repository.dart',
    ).readAsStringSync();
    expect(source, contains("{'ID', 'locale'}"));
    expect(source, contains('QuestRequestItemsLocaleKey originalKey'));
    expect(source, contains(').update(model.toJson())'));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveQuestRequestItemsLocale(')));
    expect(source, isNot(contains('saveQuestRequestItemsLocales(')));
  });

  test('Editor loads Brief and preserves hidden fields from original row', () {
    final source = File(
      'lib/widget/foxy_locale_picker_delegates.dart',
    ).readAsStringSync();
    expect(source, contains('getBriefQuestRequestItemsLocales(id: entry)'));
    expect(source, contains('countQuestRequestItemsLocales(id: entry)'));
    expect(source, contains('getQuestRequestItemsLocale(brief.key)'));
    expect(source, contains('QuestRequestItemsLocaleKey('));
    expect(source, contains('applyQuestRequestItemsLocaleChanges('));
    expect(source, isNot(contains('getQuestRequestItemsLocales(entry)')));
  });
}
