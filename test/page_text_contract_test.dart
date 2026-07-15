import 'support/entity_validation_test_extensions.dart';
import 'dart:io';

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

  test('Repository 校验链路、复合键并保护全部反向引用', () {
    final source = File(
      'lib/repository/page_text_repository.dart',
    ).readAsStringSync();
    expect(source, contains('await _validateNextPage('));
    expect(source, contains(".where('NextPageID', id)"));
    expect(source, contains(".table('item_template')"));
    expect(source, contains(".where('PageText', id)"));
    expect(source, contains(".where('type', 9)"));
    expect(source, contains(".where('Data0', id)"));
    expect(source, contains(".where('type', 10)"));
    expect(source, contains(".where('Data7', id)"));
    expect(source, contains(".table(_localeTable).where('ID', id).delete()"));
    expect(source, contains('final localeKeys = <String>{};'));
    expect(source, isNot(contains('.validate()')));
    final viewModel = File(
      'lib/page/page_text/page_text_detail_view_model.dart',
    ).readAsStringSync();
    expect(viewModel, contains('validatePageTextFields(data);'));
    expect(source, contains('final locales = _prepareLocales('));
  });

  test('主表和 locale 表单每行均为四列等宽且使用正确控件', () {
    final view = File(
      'lib/page/page_text/page_text_view.dart',
    ).readAsStringSync();
    expect(view, contains('FoxyEntityPickerDelegates.pageText'));
    expect('Expanded(child:'.allMatches(view), hasLength(4));
    expect(view, isNot(contains('flex:')));
    expect(view, isNot(contains('description:')));

    final localeView = File(
      'lib/page/page_text/page_text_locale_view.dart',
    ).readAsStringSync();
    expect('Expanded('.allMatches(localeView), hasLength(4));
    expect(localeView, contains("placeholder: 'ID'"));
    expect(localeView, contains("placeholder: const Text('locale')"));
    expect(localeView, contains("placeholder: 'Text'"));
    expect(localeView, contains("placeholder: 'VerifiedBuild'"));
    expect(localeView, isNot(contains('flex:')));
    expect(localeView, isNot(contains('description:')));
  });

  test('locale ViewModel 不再固定分配十六个文本 Controller', () {
    final source = File(
      'lib/page/page_text/page_text_locale_view_model.dart',
    ).readAsStringSync();
    expect(source, contains('class PageTextLocaleForm'));
    expect(source, contains('final idController = IntFieldController();'));
    expect(source, contains('final localeController ='));
    expect(source, contains('final textController = StringFieldController();'));
    expect(source, contains('final verifiedBuildController ='));
    expect(source, isNot(contains('localeController0')));
    expect(source, isNot(contains('for (var i = 0; i < 16; i++)')));
  });

  test('新建主记录保存前禁用 locale Tab，保存后使用真实 ID 启用', () {
    final page = File(
      'lib/page/page_text/page_text_detail_page.dart',
    ).readAsStringSync();
    expect(page, contains('disabledIndexes: savedId == null'));
    expect(page, contains('onSaved: (id) => setState(() => savedId = id)'));
    expect(page, contains('PageTextLocaleView(id: savedId)'));
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
