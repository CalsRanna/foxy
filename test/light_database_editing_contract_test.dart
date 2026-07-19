import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_light_entity.dart';
import 'package:foxy/entity/light_entity.dart';
import 'package:foxy/entity/light_key.dart';

void main() {
  test('LightKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const first = LightKey(id: 9);
    const same = LightKey(id: 9);

    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(first, isNot(const LightKey(id: 10)));
    expect(LightKey.fromEntity(const LightEntity(id: 9)), first);
    expect(const BriefLightEntity(id: 9).key, first);
  });

  test('Light Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/light_repository.dart',
    ).readAsStringSync();

    expect(source, contains('Future<LightKey> copyLight('));
    expect(source, contains('Future<void> storeLight('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeLight')));
    expect(source, isNot(contains('saveLight(')));
    expect(source, isNot(contains('insertAndGetId')));

    expect(source, contains('LightKey originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
