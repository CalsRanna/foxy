import 'support/entity_validation_test_extensions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/page_text_constants.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';

void main() {
  test('page_text Entity 精确覆盖四个标量物理列', () {
    final json = const PageTextEntity().toJson();
    expect(json.keys.toList(), ['ID', 'Text', 'NextPageID', 'VerifiedBuild']);
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);

    final entity = PageTextEntity.fromJson({
      'ID': 15, 'Text': '第一页', 'NextPageID': 16, 'VerifiedBuild': 12340,
      'localeText': '不得进入完整 Entity',
    });
    expect(entity.toJson(), {
      'ID': 15, 'Text': '第一页', 'NextPageID': 16, 'VerifiedBuild': 12340,
    });
  });

  test('主表 Brief 独立于完整 Entity 并暴露强类型定位器', () {
    final brief = BriefPageTextEntity.fromJson({
      'ID': 15, 'Text': '第一页', 'NextPageID': 16,
      'localeText': '本地化第一页', 'VerifiedBuild': 12340,
    });
    expect(brief.displayText, '本地化第一页');
    expect(brief.key, 15);
  });

  test('page_text_locale Entity 精确覆盖复合键及四个标量物理列', () {
    final entity = PageTextLocaleEntity.fromJson({
      'ID': 15, 'locale': 'zhCN', 'Text': '本地化文本', 'VerifiedBuild': null,
    });
    expect(entity.toJson(), {
      'ID': 15, 'locale': 'zhCN', 'Text': '本地化文本', 'VerifiedBuild': 0,
    });
    expect(entity.toJson().values.whereType<List<Object?>>(), isEmpty);
    expect(entity.toJson().values.whereType<Map<Object?, Object?>>(), isEmpty);
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

  test('字段范围与 AzerothCore page text 加载约束一致', () {
    expect(const PageTextEntity(id: 1, nextPageId: 0).validate, returnsNormally);
    expect(() => const PageTextEntity(id: 0).validate(), throwsRangeError);
    expect(() => const PageTextEntity(id: 1, nextPageId: -1).validate(), throwsRangeError);
    expect(() => const PageTextEntity(id: 1, verifiedBuild: 0x80000000).validate(), throwsRangeError);
  });

  test('locale 仅允许 LoadPageTextLocales 实际加载的八种代码', () {
    expect(kPageTextLocaleOptions.keys.toSet(), {
      'koKR', 'frFR', 'deDE', 'zhCN', 'zhTW', 'esES', 'esMX', 'ruRU',
    });
    for (final locale in kPageTextLocaleOptions.keys) {
      expect(PageTextLocaleEntity(id: 1, locale: locale).validate, returnsNormally);
    }
    expect(() => const PageTextLocaleEntity(id: 1, locale: 'enUS').validate(), throwsArgumentError);
    expect(() => const PageTextLocaleEntity(id: 1, locale: 'ptBR').validate(), throwsArgumentError);
  });
}
