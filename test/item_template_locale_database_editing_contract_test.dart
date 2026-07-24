import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/item_template_locale_entity.dart';

void main() {
  test('Key 与 Brief 使用 ID + locale 完整定位', () {
    const first = ItemTemplateLocaleKey(id: 12, locale: 'zhCN');
    const same = ItemTemplateLocaleKey(id: 12, locale: 'zhCN');
    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(first, isNot(const ItemTemplateLocaleKey(id: 13, locale: 'zhCN')));
    expect(first, isNot(const ItemTemplateLocaleKey(id: 12, locale: 'deDE')));

    final brief = BriefItemTemplateLocaleEntity.fromJson({
      'ID': 12,
      'locale': 'zhCN',
      'Name': '物品',
    });
    expect(brief.key, first);
    expect(brief.name, '物品');
    expect(
      File('lib/entity/item_template_locale_entity.dart').readAsStringSync(),
      isNot(contains('class BriefItemTemplateLocaleEntity')),
    );
  });

  test('Repository writes use original typed key and complete candidate', () {
    final source = File(
      'lib/repository/item_template_locale_repository.dart',
    ).readAsStringSync();
    expect(source, contains("{'ID', 'locale'}"));
    expect(source, contains('ItemTemplateLocaleKey originalKey'));
    expect(source, contains(').update(model.toJson())'));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveItemTemplateLocale(')));
    expect(source, isNot(contains('saveItemTemplateLocales(')));
    expect(source, isNot(contains("json.remove('ID')")));
    expect(source, isNot(contains("json.remove('locale')")));
  });

  test('Editor loads Brief rows and converts original locale to typed key', () {
    final source = File(
      'lib/widget/foxy_locale_picker_delegates.dart',
    ).readAsStringSync();
    expect(source, contains('repo.getBriefItemTemplateLocales(id: entry)'));
    expect(source, contains('repo.countItemTemplateLocales(id: entry)'));
    expect(source, contains('repo.getItemTemplateLocale(brief.key)'));
    expect(source, contains('locale: originalLocale'));
    expect(source, contains('updates[originalKey] = existing.copyWith('));
    expect(source, contains('applyItemTemplateLocaleChanges('));
    expect(source, isNot(contains('getItemTemplateLocales(entry)')));
  });
}
