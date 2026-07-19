import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_vehicle_entity.dart';
import 'package:foxy/entity/vehicle_key.dart';

void main() {
  test('VehicleKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = VehicleKey(id: 7);
    expect(key, const VehicleKey(id: 7));
    expect(key.hashCode, const VehicleKey(id: 7).hashCode);
    expect(const BriefVehicleEntity(id: 7).key, key);
  });

  test('Vehicle Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/vehicle_repository.dart',
    ).readAsStringSync();
    expect(source, contains('VehicleKey key'));
    expect(source, contains('Future<void> storeVehicle('));
    expect(source, contains('VehicleKey originalKey'));
    expect(source, contains('.update(vehicle.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveVehicle(')));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefVehicle 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_vehicle_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
