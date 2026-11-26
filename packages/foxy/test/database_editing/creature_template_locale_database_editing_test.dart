import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_template_locale_entity.dart';

import 'row_key_expectations.dart';

void main() {
  test('The key and brief entity both include entry and locale', () {
    const first = CreatureTemplateLocaleKey(entry: 41, locale: 'zhCN');
    expectKeyEquality(
      first,
      sameKey: const CreatureTemplateLocaleKey(entry: 41, locale: 'zhCN'),
      differentKeys: const [
        CreatureTemplateLocaleKey(entry: 42, locale: 'zhCN'),
        CreatureTemplateLocaleKey(entry: 41, locale: 'deDE'),
      ],
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
