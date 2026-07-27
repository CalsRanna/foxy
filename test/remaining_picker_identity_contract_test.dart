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

  test('waypoint Picker 使用只读分组标识', () {
    expect(
      BriefWaypointDataEntity.fromJson({'id': 10, 'points': 3}).key,
      const WaypointDataKey(id: 10),
    );
  });
}
