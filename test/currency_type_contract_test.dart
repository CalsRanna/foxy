import 'support/entity_validation_test_extensions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/currency_type_constants.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';
import 'package:foxy/entity/currency_category_entity.dart';
import 'package:foxy/entity/currency_type_entity.dart';

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
      'ID', 'Flags', 'Name_lang_enUS', 'Name_lang_koKR', 'Name_lang_frFR',
      'Name_lang_deDE', 'Name_lang_zhCN', 'Name_lang_zhTW', 'Name_lang_esES',
      'Name_lang_esMX', 'Name_lang_ruRU', 'Name_lang_jaJP', 'Name_lang_ptPT',
      'Name_lang_ptBR', 'Name_lang_itIT', 'Name_lang_unk1', 'Name_lang_unk2',
      'Name_lang_unk3', 'Name_lang_Flags',
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
        id: 1, itemId: 43308, categoryId: 2089878896, bitIndex: 64,
      ).validate,
      returnsNormally,
    );
    expect(
      () => const CurrencyTypeEntity(
        id: 1, itemId: 43308, categoryId: 2, bitIndex: 0,
      ).validate(),
      throwsArgumentError,
    );
    expect(
      () => const CurrencyTypeEntity(
        id: 1, itemId: 43308, categoryId: 2, bitIndex: 65,
      ).validate(),
      throwsArgumentError,
    );
  });

  test('CurrencyCategory 保留独立 Flags 和本地化 Flags 的 signed int32', () {
    expect(
      const CurrencyCategoryEntity(
        id: 3, flags: 3, nameLangZhCN: '未使用', nameLangFlags: 16712190,
      ).validate,
      returnsNormally,
    );
    expect(
      () => const CurrencyCategoryEntity(id: 1, flags: 0x80000000).validate(),
      throwsArgumentError,
    );
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
    expect(DbcLocaleFields.currencyCategoryName.tableName, 'dbc_currency_category');
    expect(DbcLocaleFields.currencyCategoryName.columnPrefix, 'Name_lang');
  });
}
