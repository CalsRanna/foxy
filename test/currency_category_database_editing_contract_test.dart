import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_currency_category_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect(const BriefCurrencyCategoryEntity(id: 7).key, key);
  });

  test('CurrencyCategory Repository 使用显式键和单表边界', () {
    final source = File(
      'lib/repository/currency_category_repository.dart',
    ).readAsStringSync();
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storeCurrencyCategory('));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(category.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveCurrencyCategoryLocales('));
    expect(
      source,
      isNot(contains('saveCurrencyCategory(CurrencyCategoryEntity')),
    );
    expect(source, isNot(contains("table('foxy.dbc_currency_types')")));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefCurrencyCategory 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_currency_category_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
