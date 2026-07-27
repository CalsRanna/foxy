import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_template_locale_entity.dart';

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
}
