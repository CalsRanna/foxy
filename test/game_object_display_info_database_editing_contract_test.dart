import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_game_object_display_info_entity.dart';
import 'package:foxy/entity/game_object_display_info_entity.dart';
import 'package:foxy/entity/game_object_display_info_key.dart';

void main() {
  test('GameObjectDisplayInfoKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const first = GameObjectDisplayInfoKey(id: 8);
    expect(first, const GameObjectDisplayInfoKey(id: 8));
    expect(first.hashCode, const GameObjectDisplayInfoKey(id: 8).hashCode);
    expect(first, isNot(const GameObjectDisplayInfoKey(id: 9)));
    expect(
      GameObjectDisplayInfoKey.fromEntity(
        const GameObjectDisplayInfoEntity(id: 8),
      ),
      first,
    );
    expect(const BriefGameObjectDisplayInfoEntity(id: 8).key, first);
  });

  test('GameObjectDisplayInfo Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/game_object_display_info_repository.dart',
    ).readAsStringSync();
    expect(
      source,
      contains('Future<GameObjectDisplayInfoKey> copyGameObjectDisplayInfo('),
    );
    expect(source, contains('Future<void> storeGameObjectDisplayInfo('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeGameObjectDisplayInfo')));
    expect(source, isNot(contains('saveGameObjectDisplayInfo(')));
    expect(source, contains('GameObjectDisplayInfoKey originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
