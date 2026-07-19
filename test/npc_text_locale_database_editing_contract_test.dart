import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_npc_text_locale_entity.dart';
import 'package:foxy/entity/npc_text_locale_key.dart';

void main() {
  test('Key 与 Brief 完整覆盖 ID + Locale', () {
    const first = NpcTextLocaleKey(id: 33, locale: 'zhCN');
    const same = NpcTextLocaleKey(id: 33, locale: 'zhCN');
    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(first, isNot(const NpcTextLocaleKey(id: 34, locale: 'zhCN')));
    expect(first, isNot(const NpcTextLocaleKey(id: 33, locale: 'deDE')));

    final brief = BriefNpcTextLocaleEntity.fromJson({
      'ID': 33,
      'Locale': 'zhCN',
    });
    expect(brief.key, first);
    expect(
      File('lib/entity/npc_text_locale_entity.dart').readAsStringSync(),
      isNot(contains('class BriefNpcTextLocaleEntity')),
    );
  });

  test('Repository uses original key, all 18 columns, and affected rows', () {
    final source = File(
      'lib/repository/npc_text_locale_repository.dart',
    ).readAsStringSync();
    expect(source, contains("{'ID', 'Locale'}"));
    expect(source, contains('NpcTextLocaleKey originalKey'));
    expect(source, contains(').update(model.toJson())'));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveNpcTextLocale(')));
    expect(source, isNot(contains('saveNpcTextLocales(')));
    expect(source, isNot(contains("json.remove('ID')")));
    expect(source, isNot(contains("json.remove('Locale')")));
  });

  test('ViewModel keeps original locale editing key through failed writes', () {
    final source = File(
      'lib/page/gossip_menu/npc_text_view_model.dart',
    ).readAsStringSync();
    expect(source, contains('signal<NpcTextLocaleKey?>(null)'));
    expect(
      source,
      contains('final originalLocaleKey = localeEditingKey.value;'),
    );
    expect(
      source,
      contains('updateNpcTextLocale(\n            originalLocaleKey,'),
    );
    expect(source, contains('destroyNpcTextLocale(originalLocaleKey)'));
    final updateIndex = source.indexOf('updateNpcTextLocale(');
    final replaceIndex = source.indexOf(
      'localeEditingKey.value = NpcTextLocaleKey.fromEntity(locale);',
    );
    expect(replaceIndex, greaterThan(updateIndex));
    expect(source, isNot(contains('localeExists')));
  });
}
