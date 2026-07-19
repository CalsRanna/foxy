import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_scaling_stat_distribution_entity.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';
import 'package:foxy/entity/scaling_stat_distribution_key.dart';

void main() {
  test('ScalingStatDistributionKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = ScalingStatDistributionKey(id: 7);
    expect(key, const ScalingStatDistributionKey(id: 7));
    expect(key.hashCode, const ScalingStatDistributionKey(id: 7).hashCode);
    expect(
      ScalingStatDistributionKey.fromEntity(
        const ScalingStatDistributionEntity(id: 7),
      ),
      key,
    );
    expect(const BriefScalingStatDistributionEntity(id: 7).key, key);
  });

  test('ScalingStatDistribution 路由只携带 typed key 且列表传 brief.key', () {
    final page = File(
      'lib/page/scaling_stat_distribution/scaling_stat_distribution_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/scaling_stat_distribution/scaling_stat_distribution_list_page.dart',
    ).readAsStringSync();
    expect(
      page,
      contains('final ScalingStatDistributionKey? scalingStatDistributionKey'),
    );
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('items[row].key'));
  });

  test('BriefScalingStatDistribution 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_scaling_stat_distribution_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
