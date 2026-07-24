import 'support/entity_validation_test_extensions.dart';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/currency_type_constants.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';
import 'package:foxy/entity/currency_category_entity.dart';
import 'package:foxy/entity/currency_type_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('CurrencyTypes Entity 精确覆盖 4 个独立标量物理列', () {
    final json = const CurrencyTypeEntity().toJson();
    expect(json.keys.toList(), ['ID', 'ItemID', 'CategoryID', 'BitIndex']);
    expect(json.values, everyElement(isA<int>()));
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

  test('CurrencyCategory Entity 精确覆盖 19 个独立标量物理列', () {
    final json = const CurrencyCategoryEntity().toJson();
    expect(json.keys.toList(), [
      'ID',
      'Flags',
      'Name_lang_enUS',
      'Name_lang_koKR',
      'Name_lang_frFR',
      'Name_lang_deDE',
      'Name_lang_zhCN',
      'Name_lang_zhTW',
      'Name_lang_esES',
      'Name_lang_esMX',
      'Name_lang_ruRU',
      'Name_lang_jaJP',
      'Name_lang_ptPT',
      'Name_lang_ptBR',
      'Name_lang_itIT',
      'Name_lang_unk1',
      'Name_lang_unk2',
      'Name_lang_unk3',
      'Name_lang_Flags',
    ]);
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

  test('BitIndex 对应 64 位 knownCurrencies 且其他列使用 int32', () {
    expect(kCurrencyTokenBagFamilyMask, 0x00002000);
    expect(kCurrencyBitIndexMinimum, 1);
    expect(kCurrencyBitIndexMaximum, 64);
    expect(
      const CurrencyTypeEntity(
        id: 1,
        itemId: 43308,
        categoryId: 2089878896,
        bitIndex: 64,
      ).validate,
      returnsNormally,
    );
    expect(
      () => const CurrencyTypeEntity(
        id: 1,
        itemId: 43308,
        categoryId: 2,
        bitIndex: 0,
      ).validate(),
      throwsArgumentError,
    );
    expect(
      () => const CurrencyTypeEntity(
        id: 1,
        itemId: 43308,
        categoryId: 2,
        bitIndex: 65,
      ).validate(),
      throwsArgumentError,
    );
  });

  test('CurrencyCategory 保留独立 Flags 和本地化 Flags 的 signed int32', () {
    expect(
      const CurrencyCategoryEntity(
        id: 3,
        flags: 3,
        nameLangZhCN: '未使用',
        nameLangFlags: 16712190,
      ).validate,
      returnsNormally,
    );
    expect(
      () => const CurrencyCategoryEntity(id: 1, flags: 0x80000000).validate(),
      throwsArgumentError,
    );
  });

  test('详情页使用物品和独立货币分类 Picker 且单行四列等宽', () {
    final view = File(
      'lib/page/currency_type/currency_type_view.dart',
    ).readAsStringSync();
    expect(view, contains('FoxyEntityPickerDelegates.itemTemplate,'));
    expect(view, contains('FoxyEntityPickerDelegates.currencyCategory,'));
    expect('Expanded(child:'.allMatches(view), hasLength(4));
    expect(view, isNot(contains('flex:')));
  });

  test('Entity、ViewModel 和 UI 未用集合管理物理字段', () {
    final entity = File(
      'lib/entity/currency_type_entity.dart',
    ).readAsStringSync();
    final category = File(
      'lib/entity/currency_category_entity.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/currency_type/currency_type_detail_view_model.dart',
    ).readAsStringSync();
    for (final source in [entity, category, viewModel]) {
      expect(source, isNot(contains('final List<')));
      expect(source, isNot(contains('final Map<')));
      expect(source, isNot(contains('List.generate')));
      expect(source, isNot(contains('for (')));
    }
  });

  test('Repository 使用原始键、数据库唯一约束和单表边界', () {
    final repository = readLocalDartLibrarySource(
      'lib/repository/currency_type_repository.dart',
    );
    final viewModel = File(
      'lib/page/currency_type/currency_type_detail_view_model.dart',
    ).readAsStringSync();
    expect(repository, contains('currencyType.id <= 0'));
    expect(repository, isNot(contains('.validate()')));
    expect(viewModel, contains('validateCurrencyTypeFields(candidate);'));
    expect(repository, contains('int originalKey'));
    expect(repository, contains('.update(currencyType.toJson())'));
    expect(repository, contains('matchedRows == 0'));
    expect(repository, contains('deletedRows == 0'));
    expect(repository, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(repository, isNot(contains("table('item_template')")));
    expect(repository, isNot(contains("table('foxy.dbc_currency_category')")));
    expect(repository, isNot(contains('knownCurrencies')));
    expect(repository, isNot(contains("remove('ID')")));
  });

  test('列表 locale JOIN 限定 zhCN、名称筛选生效且无复制入口', () {
    final repository = readLocalDartLibrarySource(
      'lib/repository/currency_type_repository.dart',
    );
    final page = File(
      'lib/page/currency_type/currency_type_list_page.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/currency_type/currency_type_list_view_model.dart',
    ).readAsStringSync();
    expect(repository, contains("where('itl.locale', 'zhCN')"));
    expect(repository, contains("query.where('it.name'"));
    expect(repository, contains("query.orWhere('itl.Name'"));
    expect(viewModel, contains('name: nameController.collect()'));
    expect(page, isNot(contains('viewModel.copyCurrencyType')));
    expect(page, isNot(contains("child: Text('复制')")));
  });

  test('详情使用 persistedKey 区分增改并在成功后切换身份', () {
    final viewModel = File(
      'lib/page/currency_type/currency_type_detail_view_model.dart',
    ).readAsStringSync();
    final page = File(
      'lib/page/currency_type/currency_type_detail_page.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/currency_type/currency_type_view.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/currency_type/currency_type_list_page.dart',
    ).readAsStringSync();
    expect(viewModel, contains('signal<int?>(null)'));
    expect(viewModel, contains('final originalKey = persistedKey.value'));
    expect(viewModel, contains('updateCurrencyType(originalKey, candidate)'));
    expect(viewModel, contains('persistedKey.value = candidate.id'));
    expect(viewModel, isNot(contains('getCurrencyType(candidate.id)')));
    expect(page, contains('final int? currencyTypeKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(view, isNot(contains('readOnly: true')));
    expect(list, contains('items[row].key'));
  });

  test('CurrencyTypes 与 CurrencyCategory 使用 3.3.5.12340 物理格式', () {
    final types = dbcDefinitionByTable['dbc_currency_types']!;
    expect(types.fileName, 'CurrencyTypes.dbc');
    expect(types.schema.format, 'niii');
    expect(types.schema.fields, hasLength(4));

    final category = dbcDefinitionByTable['dbc_currency_category']!;
    expect(category.fileName, 'CurrencyCategory.dbc');
    expect(category.schema.format, 'nissssssssssssssssi');
    expect(category.schema.fields, hasLength(19));
    expect(
      DbcLocaleFields.currencyCategoryName.tableName,
      'dbc_currency_category',
    );
    expect(DbcLocaleFields.currencyCategoryName.columnPrefix, 'Name_lang');
  });

  test('CurrencyCategory 完成 Repository、DI、Picker、本地化和导出注册', () {
    final di = File('lib/di.dart').readAsStringSync();
    final picker = File(
      'lib/widget/foxy_entity_picker_delegates.dart',
    ).readAsStringSync();
    final locale = File(
      'lib/widget/foxy_locale_picker_delegates.dart',
    ).readAsStringSync();
    final export = File(
      'lib/infrastructure/dbc/dbc_export_registry.dart',
    ).readAsStringSync();
    expect(di, contains('CurrencyCategoryRepository()'));
    expect(picker, contains('static final currencyCategory ='));
    expect(locale, contains('static final dbcCurrencyCategoryName ='));
    expect(
      export,
      contains("'dbc_currency_category': DbcExportDelegate.typed("),
    );
  });
}
