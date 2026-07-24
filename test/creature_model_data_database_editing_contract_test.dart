import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_creature_model_data_entity.dart';

void main() {
  test('Brief 安全解码并返回物理 ID 标量', () {
    const key = 7;
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
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storeCreatureModelData('));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(entity.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveCreatureModelData(')));
    expect(source, isNot(contains("remove('ID')")));
  });
}
