import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_item_random_properties_entity.dart';
import 'package:foxy/entity/item_random_properties_key.dart';

void main() {
  test('ItemRandomPropertiesKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = ItemRandomPropertiesKey(id: 7);
    expect(key, const ItemRandomPropertiesKey(id: 7));
    expect(key.hashCode, const ItemRandomPropertiesKey(id: 7).hashCode);
    expect(const BriefItemRandomPropertiesEntity(id: 7).key, key);
  });

  test('ItemRandomProperties Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/item_random_properties_repository.dart',
    ).readAsStringSync();
    expect(source, contains('ItemRandomPropertiesKey key'));
    expect(source, contains('Future<void> storeItemRandomProperty('));
    expect(source, contains('ItemRandomPropertiesKey originalKey'));
    expect(source, contains('.update(property.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveItemRandomPropertiesLocales('));
    expect(source, isNot(contains('saveItemRandomProperty(')));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefItemRandomProperties 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_item_random_properties_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
