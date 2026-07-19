import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_currency_type_entity.dart';
import 'package:foxy/entity/currency_type_entity.dart';
import 'package:foxy/entity/currency_type_key.dart';

void main() {
  test('CurrencyTypeKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = CurrencyTypeKey(id: 7);
    expect(key, const CurrencyTypeKey(id: 7));
    expect(key.hashCode, const CurrencyTypeKey(id: 7).hashCode);
    expect(CurrencyTypeKey.fromEntity(const CurrencyTypeEntity(id: 7)), key);
    expect(const BriefCurrencyTypeEntity(id: 7).key, key);
  });

  test('BriefCurrencyType 只保留展示和定位字段', () {
    final source = File(
      'lib/entity/brief_currency_type_entity.dart',
    ).readAsStringSync();
    expect(source, contains('String get displayItemName'));
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
