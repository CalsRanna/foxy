import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_creature_spell_data_entity.dart';
import 'package:foxy/entity/creature_spell_data_key.dart';

void main() {
  test('CreatureSpellDataKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = CreatureSpellDataKey(id: 7);
    expect(key, const CreatureSpellDataKey(id: 7));
    expect(key.hashCode, const CreatureSpellDataKey(id: 7).hashCode);
    expect(const BriefCreatureSpellDataEntity(id: 7).key, key);
  });

  test('CreatureSpellData Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/creature_spell_data_repository.dart',
    ).readAsStringSync();
    expect(source, contains('CreatureSpellDataKey key'));
    expect(source, contains('Future<void> storeCreatureSpellData('));
    expect(source, contains('CreatureSpellDataKey originalKey'));
    expect(source, contains('.update(data.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveCreatureSpellData(')));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefCreatureSpellData 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_creature_spell_data_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
