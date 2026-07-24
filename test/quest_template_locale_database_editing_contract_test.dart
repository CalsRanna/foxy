import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/quest_template_locale_entity.dart';

void main() {
  test('Key 与 Brief 完整覆盖 ID + locale', () {
    const first = QuestTemplateLocaleKey(id: 21, locale: 'zhCN');
    const same = QuestTemplateLocaleKey(id: 21, locale: 'zhCN');
    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(first, isNot(const QuestTemplateLocaleKey(id: 22, locale: 'zhCN')));
    expect(first, isNot(const QuestTemplateLocaleKey(id: 21, locale: 'deDE')));

    final brief = BriefQuestTemplateLocaleEntity.fromJson({
      'ID': 21,
      'locale': 'zhCN',
      'Title': '任务标题',
    });
    expect(brief.key, first);
    expect(brief.title, '任务标题');
    expect(
      File('lib/entity/quest_template_locale_entity.dart').readAsStringSync(),
      isNot(contains('class BriefQuestTemplateLocaleEntity')),
    );
  });

  test('Repository uses original key, full candidate, and affected rows', () {
    final source = File(
      'lib/repository/quest_template_locale_repository.dart',
    ).readAsStringSync();
    expect(source, contains("{'ID', 'locale'}"));
    expect(source, contains('QuestTemplateLocaleKey originalKey'));
    expect(source, contains(').update(model.toJson())'));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveQuestTemplateLocale(')));
    expect(source, isNot(contains('saveQuestTemplateLocales(')));
  });

  test('Editor loads Brief and preserves hidden VerifiedBuild', () {
    final source = File(
      'lib/widget/foxy_locale_picker_delegates.dart',
    ).readAsStringSync();
    expect(source, contains('getBriefQuestTemplateLocales(id: entry)'));
    expect(source, contains('countQuestTemplateLocales(id: entry)'));
    expect(source, contains('getQuestTemplateLocale(brief.key)'));
    expect(source, contains('QuestTemplateLocaleKey('));
    expect(source, contains('updates[originalKey] = existing.copyWith('));
    expect(source, contains('applyQuestTemplateLocaleChanges('));
    expect(source, isNot(contains('getQuestTemplateLocales(entry)')));
  });
}
