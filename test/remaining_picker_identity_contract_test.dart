import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/holiday_entity.dart';
import 'package:foxy/entity/item_limit_category_entity.dart';
import 'package:foxy/entity/totem_category_entity.dart';
import 'package:foxy/entity/brief_waypoint_data_entity.dart';
import 'package:foxy/entity/waypoint_data_key.dart';

void main() {
  test('DBC Picker Brief 只读取精确物理列名', () {
    expect(BriefHolidayEntity.fromJson({'ID': 7}).key, 7);
    expect(BriefItemLimitCategoryEntity.fromJson({'ID': 8}).key, 8);
    expect(BriefTotemCategoryEntity.fromJson({'ID': 9}).key, 9);
    expect(BriefHolidayEntity.fromJson({'id': 7}).key, 0);
    expect(BriefItemLimitCategoryEntity.fromJson({'id': 8}).key, 0);
    expect(BriefTotemCategoryEntity.fromJson({'id': 9}).key, 0);
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

  test('标准 Picker Brief 合并到所属 Full Entity library', () {
    for (final name in ['holiday', 'item_limit_category', 'totem_category']) {
      expect(
        File('lib/entity/brief_${name}_entity.dart').existsSync(),
        isFalse,
      );
      expect(
        File('lib/entity/${name}_entity.dart').readAsStringSync(),
        contains('@FoxyBriefEntity()'),
      );
      expect(
        File('lib/entity/${name}_entity.g.dart').readAsStringSync(),
        contains('final class Brief'),
      );
    }
  });
}
