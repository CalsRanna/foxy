import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';

void main() {

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
