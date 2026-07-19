import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_item_purchase_group_entity.dart';
import 'package:foxy/entity/item_purchase_group_key.dart';

void main() {
  test('ItemPurchaseGroupKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = ItemPurchaseGroupKey(id: 7);
    expect(key, const ItemPurchaseGroupKey(id: 7));
    expect(key.hashCode, const ItemPurchaseGroupKey(id: 7).hashCode);
    expect(const BriefItemPurchaseGroupEntity(id: 7).key, key);
  });

  test('ItemPurchaseGroup Repository 使用显式键和单表边界', () {
    final source = File(
      'lib/repository/item_purchase_group_repository.dart',
    ).readAsStringSync();
    expect(source, contains('ItemPurchaseGroupKey key'));
    expect(source, contains('Future<void> storeItemPurchaseGroup('));
    expect(source, contains('ItemPurchaseGroupKey originalKey'));
    expect(source, contains('.update(group.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveItemPurchaseGroupLocales('));
    expect(source, isNot(contains('saveItemPurchaseGroup(')));
    expect(source, isNot(contains("table('foxy.dbc_item_extended_cost')")));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefItemPurchaseGroup 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_item_purchase_group_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
