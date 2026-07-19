import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_holiday_entity.dart';
import 'package:foxy/entity/brief_item_limit_category_entity.dart';
import 'package:foxy/entity/brief_totem_category_entity.dart';
import 'package:foxy/entity/brief_waypoint_data_entity.dart';
import 'package:foxy/entity/holiday_key.dart';
import 'package:foxy/entity/item_limit_category_key.dart';
import 'package:foxy/entity/totem_category_key.dart';
import 'package:foxy/entity/waypoint_data_key.dart';

void main() {
  test('剩余 DBC Picker Brief 实体暴露完整强类型主键', () {
    expect(BriefHolidayEntity.fromJson({'ID': 7}).key, const HolidayKey(id: 7));
    expect(
      BriefItemLimitCategoryEntity.fromJson({'ID': 8}).key,
      const ItemLimitCategoryKey(id: 8),
    );
    expect(
      BriefTotemCategoryEntity.fromJson({'ID': 9}).key,
      const TotemCategoryKey(id: 9),
    );
  });

  test('waypoint Picker 使用只读分组标识且仓储不暴露伪 CRUD', () {
    expect(
      BriefWaypointDataEntity.fromJson({'id': 10, 'points': 3}).key,
      const WaypointDataKey(id: 10),
    );

    final source = File(
      'lib/repository/waypoint_data_repository.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('createWaypointData')));
    expect(source, isNot(contains('copyWaypointData')));
    expect(source, isNot(contains('destroyWaypointData')));
    expect(source, isNot(contains('saveWaypointData')));
    expect(source, isNot(contains('storeWaypointData')));
    expect(source, isNot(contains('updateWaypointData')));
  });

  test('Picker Brief 实体独立于 Full Entity 且不携带写入载荷 API', () {
    for (final path in [
      'lib/entity/brief_holiday_entity.dart',
      'lib/entity/brief_item_limit_category_entity.dart',
      'lib/entity/brief_totem_category_entity.dart',
      'lib/entity/brief_waypoint_data_entity.dart',
    ]) {
      final source = File(path).readAsStringSync();
      expect(source, contains(' get key =>'));
      expect(source, isNot(contains('copyWith(')));
      expect(source, isNot(contains('toJson(')));
    }
  });
}
