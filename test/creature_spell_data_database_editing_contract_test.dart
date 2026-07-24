import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_spell_data_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect(const BriefCreatureSpellDataEntity(id: 7).key, key);
  });

  test('CreatureSpellData Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/creature_spell_data_repository.dart',
    ).readAsStringSync();
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storeCreatureSpellData('));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(data.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveCreatureSpellData(')));
    expect(source, isNot(contains("remove('ID')")));
  });
}
