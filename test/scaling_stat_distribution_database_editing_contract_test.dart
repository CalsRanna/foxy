import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect((const ScalingStatDistributionEntity(id: 7)).id, key);
    expect(const BriefScalingStatDistributionEntity(id: 7).key, key);
    expect(
      const BriefScalingStatDistributionEntity(
        statId0: 3,
        bonus0: 5,
        statId1: 7,
        bonus1: 9,
      ).displayStats,
      '3+5, 7+9',
    );
  });

  test('ScalingStatDistribution 路由只携带标量 key 且列表传 brief.key', () {
    final page = File(
      'lib/page/scaling_stat_distribution/scaling_stat_distribution_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/scaling_stat_distribution/scaling_stat_distribution_list_page.dart',
    ).readAsStringSync();
    expect(page, contains('final int? scalingStatDistributionKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('items[row].key'));
  });
}
