import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_item_extended_cost_entity.dart';
import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/entity/item_extended_cost_key.dart';

void main() {
  test('ItemExtendedCostKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = ItemExtendedCostKey(id: 7);
    expect(key, const ItemExtendedCostKey(id: 7));
    expect(key.hashCode, const ItemExtendedCostKey(id: 7).hashCode);
    expect(
      ItemExtendedCostKey.fromEntity(const ItemExtendedCostEntity(id: 7)),
      key,
    );
    expect(const BriefItemExtendedCostEntity(id: 7).key, key);
  });

  test('ItemExtendedCost 路由只携带 typed key 且列表传 brief.key', () {
    final page = File(
      'lib/page/item_extended_cost/item_extended_cost_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/item_extended_cost/item_extended_cost_list_page.dart',
    ).readAsStringSync();
    expect(page, contains('final ItemExtendedCostKey? itemExtendedCostKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('items[row].key'));
  });

  test('BriefItemExtendedCost 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_item_extended_cost_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
