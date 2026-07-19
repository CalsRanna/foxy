import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_game_object_display_info_entity.dart';
import 'package:foxy/entity/game_object_display_info_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const first = 8;
    expect((const GameObjectDisplayInfoEntity(id: 8)).id, first);
    expect(const BriefGameObjectDisplayInfoEntity(id: 8).key, first);
  });

  test('GameObjectDisplayInfo Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/game_object_display_info_repository.dart',
    ).readAsStringSync();
    expect(source, contains('Future<int> copyGameObjectDisplayInfo('));
    expect(source, contains('Future<void> storeGameObjectDisplayInfo('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeGameObjectDisplayInfo')));
    expect(source, isNot(contains('saveGameObjectDisplayInfo(')));
    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
