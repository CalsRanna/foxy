import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/vehicle_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect(const BriefVehicleEntity(id: 7).key, key);
  });

  test('Vehicle Repository 使用显式创建键与原始更新键', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/vehicle_repository.dart',
    );
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storeVehicle('));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(vehicle.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveVehicle(')));
    expect(source, isNot(contains("remove('ID')")));
  });
}
