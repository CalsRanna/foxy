import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/game_object_template_locale_entity.dart';

import 'row_key_expectations.dart';

void main() {
  test('The key and brief entity both include entry and locale', () {
    const first = GameObjectTemplateLocaleKey(entry: 51, locale: 'zhCN');
    expectKeyEquality(
      first,
      sameKey: const GameObjectTemplateLocaleKey(entry: 51, locale: 'zhCN'),
      differentKeys: const [
        GameObjectTemplateLocaleKey(entry: 52, locale: 'zhCN'),
        GameObjectTemplateLocaleKey(entry: 51, locale: 'deDE'),
      ],
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
}
