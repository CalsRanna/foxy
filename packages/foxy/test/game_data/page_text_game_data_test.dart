import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';

void main() {
  test('The main brief entity is independent of the full entity and exposes a typed key', () {
    final brief = BriefPageTextEntity.fromJson({
      'ID': 15,
      'Text': '第一页',
      'NextPageID': 16,
      'localeText': '本地化第一页',
      'VerifiedBuild': 12340,
    });
    expect(brief.displayText, '本地化第一页');
    expect(brief.key, 15);
  });

  test('The locale brief entity includes display columns and the complete composite key', () {
    final brief = BriefPageTextLocaleEntity.fromJson({
      'ID': 15,
      'locale': 'zhCN',
      'Text': '本地化文本',
      'VerifiedBuild': 12340,
    });
    expect(brief.key, const PageTextLocaleKey(id: 15, locale: 'zhCN'));
    expect(brief.text, '本地化文本');
    expect(brief.verifiedBuild, 12340);
  });

  test('Main and locale keys use all locator columns for value equality', () {
    const first = PageTextLocaleKey(id: 1, locale: 'zhCN');
    const same = PageTextLocaleKey(id: 1, locale: 'zhCN');
    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(first, isNot(const PageTextLocaleKey(id: 2, locale: 'zhCN')));
    expect(first, isNot(const PageTextLocaleKey(id: 1, locale: 'deDE')));
  });
}
