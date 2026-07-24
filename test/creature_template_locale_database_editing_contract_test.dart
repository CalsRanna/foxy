import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_template_locale_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('Key 与 Brief 完整覆盖 entry + locale', () {
    const first = CreatureTemplateLocaleKey(entry: 41, locale: 'zhCN');
    const same = CreatureTemplateLocaleKey(entry: 41, locale: 'zhCN');
    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(
      first,
      isNot(const CreatureTemplateLocaleKey(entry: 42, locale: 'zhCN')),
    );
    expect(
      first,
      isNot(const CreatureTemplateLocaleKey(entry: 41, locale: 'deDE')),
    );

    final brief = BriefCreatureTemplateLocaleEntity.fromJson({
      'entry': 41,
      'locale': 'zhCN',
      'Name': '生物',
      'Title': '称号',
    });
    expect(brief.key, first);
    expect(brief.name, '生物');
    expect(brief.title, '称号');
  });

  test('locale Repository has one-table typed write contract', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/creature_template_locale_repository.dart',
    );
    expect(source, contains("{'entry', 'locale'}"));
    expect(source, contains('CreatureTemplateLocaleKey originalKey'));
    expect(source, contains(').update(json)'));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains(".table('creature_template')")));

    final parent = readLocalDartLibrarySource(
      'lib/repository/creature_template_repository.dart',
    );
    expect(parent, isNot(contains('saveCreatureTemplateLocales(')));
    expect(parent, isNot(contains('getCreatureTemplateLocales(')));
    expect(parent, isNot(contains('laconic.table(_localeTable)')));
  });

  test('Editor loads Brief and maps original locale to typed key', () {
    final source = File(
      'lib/widget/foxy_locale_picker_delegates.dart',
    ).readAsStringSync();
    expect(source, contains('getBriefCreatureTemplateLocales(entry: entry)'));
    expect(source, contains('countCreatureTemplateLocales(entry: entry)'));
    expect(source, contains('getCreatureTemplateLocale(brief.key)'));
    expect(source, contains('CreatureTemplateLocaleKey('));
    expect(source, contains('applyCreatureTemplateLocaleChanges('));
    expect(source, isNot(contains('getCreatureTemplateLocales(entry)')));
  });
}
