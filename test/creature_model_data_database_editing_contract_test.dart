import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_creature_model_data_entity.dart';
import 'package:foxy/entity/creature_model_data_key.dart';

void main() {
  test('CreatureModelDataKey 使用 ID 值相等且 Brief 安全解码并暴露定位器', () {
    const key = CreatureModelDataKey(id: 7);
    expect(key, const CreatureModelDataKey(id: 7));
    expect(key.hashCode, const CreatureModelDataKey(id: 7).hashCode);
    final brief = BriefCreatureModelDataEntity.fromJson(const {
      'ID': 7,
      'ModelScale': 2,
    });
    expect(brief.key, key);
    expect(brief.modelScale, 2.0);
  });

  test('CreatureModelData Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/creature_model_data_repository.dart',
    ).readAsStringSync();
    expect(source, contains('CreatureModelDataKey key'));
    expect(source, contains('Future<void> storeCreatureModelData('));
    expect(source, contains('CreatureModelDataKey originalKey'));
    expect(source, contains('.update(entity.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveCreatureModelData(')));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefCreatureModelData 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_creature_model_data_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
