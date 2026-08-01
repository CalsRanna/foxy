import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';

void main() {

  test('主表 Brief 独立于完整 Entity 并暴露强类型定位器', () {
    final brief = BriefPageTextEntity.fromJson({
      'ID': 15, 'Text': '第一页', 'NextPageID': 16,
      'localeText': '本地化第一页', 'VerifiedBuild': 12340,
    });
    expect(brief.displayText, '本地化第一页');
    expect(brief.key, 15);
  });

  test('locale Brief 包含展示列和完整联合定位器', () {
    final brief = BriefPageTextLocaleEntity.fromJson({
      'ID': 15, 'locale': 'zhCN', 'Text': '本地化文本', 'VerifiedBuild': 12340,
    });
    expect(brief.key, const PageTextLocaleKey(id: 15, locale: 'zhCN'));
    expect(brief.text, '本地化文本');
    expect(brief.verifiedBuild, 12340);
  });

  test('主表和 locale Key 对全部定位列实现值相等', () {
    const first = PageTextLocaleKey(id: 1, locale: 'zhCN');
    const same = PageTextLocaleKey(id: 1, locale: 'zhCN');
    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(first, isNot(const PageTextLocaleKey(id: 2, locale: 'zhCN')));
    expect(first, isNot(const PageTextLocaleKey(id: 1, locale: 'deDE')));
  });

}
