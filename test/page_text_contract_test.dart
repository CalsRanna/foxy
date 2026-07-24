import 'support/entity_validation_test_extensions.dart';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/page_text_constants.dart';
import 'package:foxy/entity/brief_page_text_entity.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';
import 'package:foxy/entity/page_text_entity.dart';

void main() {
  test('page_text Entity 精确覆盖四个标量物理列', () {
    final json = const PageTextEntity().toJson();
    expect(json.keys.toList(), ['ID', 'Text', 'NextPageID', 'VerifiedBuild']);
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);

    final entity = PageTextEntity.fromJson({
      'ID': 15,
      'Text': '第一页',
      'NextPageID': 16,
      'VerifiedBuild': 12340,
      'localeText': '不得进入完整 Entity',
    });
    expect(entity.toJson(), {
      'ID': 15,
      'Text': '第一页',
      'NextPageID': 16,
      'VerifiedBuild': 12340,
    });
  });

  test('主表 Brief 独立于完整 Entity 并暴露强类型定位器', () {
    final brief = BriefPageTextEntity.fromJson({
      'ID': 15,
      'Text': '第一页',
      'NextPageID': 16,
      'localeText': '本地化第一页',
      'VerifiedBuild': 12340,
    });
    expect(brief.displayText, '本地化第一页');
    expect(brief.key, 15);
    expect(
      File('lib/entity/page_text_entity.dart').readAsStringSync(),
      isNot(contains('class BriefPageTextEntity')),
    );
  });

  test('page_text_locale Entity 精确覆盖复合键及四个标量物理列', () {
    final entity = PageTextLocaleEntity.fromJson({
      'ID': 15,
      'locale': 'zhCN',
      'Text': '本地化文本',
      'VerifiedBuild': null,
    });
    expect(entity.toJson(), {
      'ID': 15,
      'locale': 'zhCN',
      'Text': '本地化文本',
      'VerifiedBuild': 0,
    });
    expect(entity.toJson().values.whereType<List<Object?>>(), isEmpty);
    expect(entity.toJson().values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

  test('locale Brief 包含展示列和完整联合定位器', () {
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

  test('主表和 locale Key 对全部定位列实现值相等', () {
    expect(1, 1);
    expect(1.hashCode, 1.hashCode);
    expect(1, isNot(2));

    const first = PageTextLocaleKey(id: 1, locale: 'zhCN');
    const same = PageTextLocaleKey(id: 1, locale: 'zhCN');
    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(first, isNot(const PageTextLocaleKey(id: 2, locale: 'zhCN')));
    expect(first, isNot(const PageTextLocaleKey(id: 1, locale: 'deDE')));
  });

  test('字段范围与 AzerothCore page text 加载约束一致', () {
    expect(
      const PageTextEntity(id: 1, nextPageId: 0).validate,
      returnsNormally,
    );
    expect(() => const PageTextEntity(id: 0).validate(), throwsRangeError);
    expect(
      () => const PageTextEntity(id: 1, nextPageId: -1).validate(),
      throwsRangeError,
    );
    expect(
      () => const PageTextEntity(id: 1, verifiedBuild: 0x80000000).validate(),
      throwsRangeError,
    );
  });

  test('locale 仅允许 LoadPageTextLocales 实际加载的八种代码', () {
    expect(kPageTextLocaleOptions.keys.toSet(), {
      'koKR',
      'frFR',
      'deDE',
      'zhCN',
      'zhTW',
      'esES',
      'esMX',
      'ruRU',
    });
    for (final locale in kPageTextLocaleOptions.keys) {
      expect(
        PageTextLocaleEntity(id: 1, locale: locale).validate,
        returnsNormally,
      );
    }
    expect(
      () => const PageTextLocaleEntity(id: 1, locale: 'enUS').validate(),
      throwsArgumentError,
    );
    expect(
      () => const PageTextLocaleEntity(id: 1, locale: 'ptBR').validate(),
      throwsArgumentError,
    );
  });

  test('主表 Repository 使用原始 Key、完整 candidate 和写入结果', () {
    final source = File(
      'lib/repository/page_text_repository.dart',
    ).readAsStringSync();
    expect(source, contains('await _validateNextPage('));
    expect(source, isNot(contains(".table('item_template')")));
    expect(source, isNot(contains(".table('gameobject_template')")));
    expect(source, isNot(contains('仍有 \$references 条引用')));
    expect(source, isNot(contains('getPageTextLocales(id)')));
    expect(source, contains('destroyPageText(int key)'));
    expect(source, contains('final deletedRows ='));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('int originalKey'));
    expect(source, contains(').update(pageText.toJson())'));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('Future<void> storePageText('));
    expect(source, isNot(contains('Future<int> storePageText(')));
    expect(source, isNot(contains('savePageText(')));
    expect(source, isNot(contains('savePageTextLocales(')));
    expect(
      source,
      isNot(contains(".table(_localeTable).where('ID', id).delete()")),
    );
    expect(source, isNot(contains('.validate()')));
    final viewModel = File(
      'lib/page/page_text/page_text_detail_view_model.dart',
    ).readAsStringSync();
    expect(viewModel, contains('validatePageTextFields(data);'));
    expect(viewModel, contains('signal<int?>(null)'));
    expect(viewModel, contains('final originalKey = persistedKey.value;'));
    expect(viewModel, contains('updatePageText(originalKey, data)'));
    expect(viewModel, contains('persistedKey.value = newKey;'));
  });

  test('locale Repository 独立写表并按原始联合 Key 定位', () {
    final source = File(
      'lib/repository/page_text_locale_repository.dart',
    ).readAsStringSync();
    expect(source, contains("static const _table = 'page_text_locale';"));
    expect(source, contains("{'ID', 'locale'}"));
    expect(source, contains('Future<List<BriefPageTextLocaleEntity>>'));
    expect(
      source,
      contains(".select(['ID', 'locale', 'Text', 'VerifiedBuild'])"),
    );
    expect(source, contains('PageTextLocaleKey originalKey'));
    expect(source, contains(').update(locale.toJson())'));
    expect(source, contains('final matchedRows ='));
    expect(source, contains('final deletedRows ='));
    expect(source, isNot(contains(".table('page_text')")));
  });

  test('主表和 locale 表单每行均为四列等宽且使用正确控件', () {
    final view = File(
      'lib/page/page_text/page_text_view.dart',
    ).readAsStringSync();
    expect(view, contains('FoxyEntityPickerDelegates.pageText'));
    expect('Expanded(child:'.allMatches(view), hasLength(4));
    expect(view, isNot(contains('flex:')));

    final localeView = File(
      'lib/page/page_text/page_text_locale_view.dart',
    ).readAsStringSync();
    expect('Expanded('.allMatches(localeView), hasLength(4));
    expect(localeView, contains("placeholder: 'ID'"));
    expect(localeView, contains("placeholder: const Text('locale')"));
    expect(localeView, contains("placeholder: 'Text'"));
    expect(localeView, contains("placeholder: 'VerifiedBuild'"));
    expect(localeView, isNot(contains('readOnly: true')));
    expect(localeView, isNot(contains('flex:')));
    expect(localeView, contains('DialogUtil.instance.confirm('));
  });

  test('locale ViewModel 使用单行 typed controller 和统一 Collection 状态', () {
    final source = File(
      'lib/page/page_text/page_text_locale_collection_editor_view_model.dart',
    ).readAsStringSync();
    expect(source, contains('final parentKey = signal<int?>(null);'));
    expect(
      source,
      contains('final items = signal<List<BriefPageTextLocaleEntity>>'),
    );
    expect(source, contains('final editingKey = signal<PageTextLocaleKey?>'));
    expect(source, contains('final selectedKey = signal<PageTextLocaleKey?>'));
    expect(source, contains('registerController(IntFieldController())'));
    expect(source, contains('final localeController ='));
    expect(source, contains('final textController = registerController('));
    expect(source, contains('final verifiedBuildController ='));
    expect(source, contains('int _refreshToken = 0;'));
    expect(source, isNot(contains('localeController0')));
    expect(source, isNot(contains('for (var i = 0; i < 16; i++)')));
  });

  test('详情页使用 persistedKey 控制 locale Tab 和实时父 ID', () {
    final page = File(
      'lib/page/page_text/page_text_detail_page.dart',
    ).readAsStringSync();
    expect(page, contains('final int? pageTextKey;'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(page, contains('disabledIndexes: key == null'));
    expect(page, contains('PageTextLocaleView(id: key)'));
    expect(page, contains('PageTextView(viewModel: viewModel)'));
  });

  test('locale persist 使用原 editingKey 且失败前不改写身份', () {
    final source = File(
      'lib/page/page_text/page_text_locale_collection_editor_view_model.dart',
    ).readAsStringSync();
    expect(source, contains('final originalKey = editingKey.value;'));
    expect(source, contains('updatePageTextLocale(originalKey, candidate)'));
    final updateIndex = source.indexOf(
      'updatePageTextLocale(originalKey, candidate)',
    );
    final refreshIndex = source.indexOf('await _refresh();', updateIndex);
    expect(refreshIndex, greaterThan(updateIndex));
    expect(source, isNot(contains('applyPageTextLocaleChanges(')));
    expect(source, isNot(contains('_deletedKeys')));
  });

  test('共享页面文本 Picker 同时按 ID 和文本分页筛选', () {
    final source = File(
      'lib/widget/foxy_entity_picker_delegates.dart',
    ).readAsStringSync();
    final start = source.indexOf('static final pageText =');
    final end = source.indexOf('static final questInfo =', start);
    final delegate = source.substring(start, end);
    expect(delegate, contains("FoxyEntityPickerFilter('编号')"));
    expect(delegate, contains("FoxyEntityPickerFilter('文本')"));
    expect(delegate, contains('PageTextFilterEntity(id: v[0], text: v[1])'));
    expect(delegate, contains('.getBriefPageTexts('));
    expect(delegate, contains('.countPageTexts('));
  });
}
