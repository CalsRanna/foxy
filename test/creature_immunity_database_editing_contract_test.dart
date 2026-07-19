import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_creature_immunity_entity.dart';
import 'package:foxy/entity/creature_immunity_key.dart';

void main() {
  test('CreatureImmunityKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = CreatureImmunityKey(id: 7);
    expect(key, const CreatureImmunityKey(id: 7));
    expect(key.hashCode, const CreatureImmunityKey(id: 7).hashCode);
    expect(const BriefCreatureImmunityEntity(id: 7).key, key);
  });

  test('CreatureImmunity Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/creature_immunity_repository.dart',
    ).readAsStringSync();
    expect(source, contains('CreatureImmunityKey key'));
    expect(source, contains('Future<void> storeCreatureImmunity('));
    expect(source, contains('CreatureImmunityKey originalKey'));
    expect(source, contains('.update(immunity.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveCreatureImmunity(')));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefCreatureImmunity 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_creature_immunity_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
