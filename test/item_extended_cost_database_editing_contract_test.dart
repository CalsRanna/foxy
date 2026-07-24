import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/item_extended_cost_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect((const ItemExtendedCostEntity(id: 7)).id, key);
    expect(const BriefItemExtendedCostEntity(id: 7).key, key);
    expect(
      const BriefItemExtendedCostEntity(
        itemID0: 100,
        itemCount0: 2,
        itemID2: 300,
        itemCount2: 4,
      ).displayItems,
      '100x2, 300x4',
    );
  });

  test('ItemExtendedCost 路由只携带标量 key 且列表传 brief.key', () {
    final page = File(
      'lib/page/item_extended_cost/item_extended_cost_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/item_extended_cost/item_extended_cost_list_page.dart',
    ).readAsStringSync();
    expect(page, contains('final int? itemExtendedCostKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('items[row].key'));
  });
}
