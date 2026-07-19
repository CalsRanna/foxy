import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_scaling_stat_value_entity.dart';
import 'package:foxy/entity/scaling_stat_value_entity.dart';
import 'package:foxy/entity/scaling_stat_value_key.dart';

void main() {
  test('ScalingStatValueKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = ScalingStatValueKey(id: 7);
    expect(key, const ScalingStatValueKey(id: 7));
    expect(key.hashCode, const ScalingStatValueKey(id: 7).hashCode);
    expect(
      ScalingStatValueKey.fromEntity(const ScalingStatValueEntity(id: 7)),
      key,
    );
    expect(const BriefScalingStatValueEntity(id: 7).key, key);
  });

  test('ScalingStatValue 路由只携带 typed key 且列表传 brief.key', () {
    final page = File(
      'lib/page/scaling_stat_value/scaling_stat_value_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/scaling_stat_value/scaling_stat_value_list_page.dart',
    ).readAsStringSync();
    expect(page, contains('final ScalingStatValueKey? scalingStatValueKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('items[row].key'));
  });

  test('BriefScalingStatValue 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_scaling_stat_value_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
