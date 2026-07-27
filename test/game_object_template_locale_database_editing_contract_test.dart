import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/game_object_template_locale_entity.dart';

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
}
