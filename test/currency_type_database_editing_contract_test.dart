import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_currency_type_entity.dart';
import 'package:foxy/entity/currency_type_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect((const CurrencyTypeEntity(id: 7)).id, key);
    expect(const BriefCurrencyTypeEntity(id: 7).key, key);
  });

  test('BriefCurrencyType 只保留展示和定位字段', () {
    final source = File(
      'lib/entity/brief_currency_type_entity.dart',
    ).readAsStringSync();
    expect(source, contains('String get displayItemName'));
  });
}
