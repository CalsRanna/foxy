import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_game_object_template_locale_entity.dart';
import 'package:foxy/entity/game_object_template_locale_key.dart';

void main() {
  test('Key 与 Brief 完整覆盖 entry + locale', () {
    const first = GameObjectTemplateLocaleKey(entry: 51, locale: 'zhCN');
    const same = GameObjectTemplateLocaleKey(entry: 51, locale: 'zhCN');
    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(
      first,
      isNot(const GameObjectTemplateLocaleKey(entry: 52, locale: 'zhCN')),
    );
    expect(
      first,
      isNot(const GameObjectTemplateLocaleKey(entry: 51, locale: 'deDE')),
    );

    final brief = BriefGameObjectTemplateLocaleEntity.fromJson({
      'entry': 51,
      'locale': 'zhCN',
      'name': '游戏对象',
      'castBarCaption': '使用说明',
    });
    expect(brief.key, first);
    expect(brief.name, '游戏对象');
    expect(brief.castBarCaption, '使用说明');
  });

  test('locale Repository has one-table typed write contract', () {
    final source = File(
      'lib/repository/game_object_template_locale_repository.dart',
    ).readAsStringSync();
    expect(source, contains("{'entry', 'locale'}"));
    expect(source, contains('GameObjectTemplateLocaleKey originalKey'));
    expect(source, contains(').update(locale.toJson())'));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains(".table('gameobject_template')")));

    final parent = File(
      'lib/repository/game_object_template_repository.dart',
    ).readAsStringSync();
    expect(parent, isNot(contains('saveGameObjectTemplateLocales(')));
    expect(parent, isNot(contains('getGameObjectTemplateLocales(')));
    expect(parent, isNot(contains('laconic.table(_localeTable)')));
  });

  test('Both field editors preserve hidden columns through original row', () {
    final source = File(
      'lib/widget/foxy_locale_picker_delegates.dart',
    ).readAsStringSync();
    expect(
      '_loadGameObjectTemplateLocaleRows('.allMatches(source).length,
      greaterThanOrEqualTo(3),
    );
    expect(source, contains('getGameObjectTemplateLocale(brief.key)'));
    expect(
      'GameObjectTemplateLocaleKey('.allMatches(source).length,
      greaterThanOrEqualTo(4),
    );
    expect(
      'applyGameObjectTemplateLocaleChanges('.allMatches(source).length,
      2,
    );
    expect(source, isNot(contains('getGameObjectTemplateLocales(entry)')));
  });
}
