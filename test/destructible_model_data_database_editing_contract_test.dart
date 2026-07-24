import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/destructible_model_data_entity.dart';

void main() {
  test('Brief key 直接解码物理 ID 标量', () {
    const key = 7;
    final brief = BriefDestructibleModelDataEntity.fromJson(const {
      'ID': 7,
      'State1WMO': 1,
      'State2WMO': 2,
      'State3WMO': 3,
    });
    expect(brief.key, key);
    expect([brief.state1Wmo, brief.state2Wmo, brief.state3Wmo], [1, 2, 3]);
  });

  test('DestructibleModelData Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/destructible_model_data_repository.dart',
    ).readAsStringSync();
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storeDestructibleModelData('));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(entity.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveDestructibleModelData(')));
    expect(source, isNot(contains("remove('ID')")));
  });
}
