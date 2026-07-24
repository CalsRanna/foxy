import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_scaling_stat_value_entity.dart';
import 'package:foxy/entity/scaling_stat_value_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect((const ScalingStatValueEntity(id: 7)).id, key);
    expect(const BriefScalingStatValueEntity(id: 7).key, key);
  });

  test('ScalingStatValue 路由只携带标量 key 且列表传 brief.key', () {
    final page = File(
      'lib/page/scaling_stat_value/scaling_stat_value_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/scaling_stat_value/scaling_stat_value_list_page.dart',
    ).readAsStringSync();
    expect(page, contains('final int? scalingStatValueKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('items[row].key'));
  });
}
