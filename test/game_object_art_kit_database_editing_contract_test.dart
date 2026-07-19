import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_game_object_art_kit_entity.dart';
import 'package:foxy/entity/game_object_art_kit_entity.dart';
import 'package:foxy/entity/game_object_art_kit_key.dart';

void main() {
  test('GameObjectArtKitKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const first = GameObjectArtKitKey(id: 2);
    const same = GameObjectArtKitKey(id: 2);

    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(first, isNot(const GameObjectArtKitKey(id: 3)));
    expect(
      GameObjectArtKitKey.fromEntity(const GameObjectArtKitEntity(id: 2)),
      first,
    );
    expect(const BriefGameObjectArtKitEntity(id: 2).key, first);
  });

  test('GameObjectArtKit Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/game_object_art_kit_repository.dart',
    ).readAsStringSync();

    expect(
      source,
      contains('Future<GameObjectArtKitKey> copyGameObjectArtKit('),
    );
    expect(source, contains('Future<void> storeGameObjectArtKit('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeGameObjectArtKit')));
    expect(source, isNot(contains('saveGameObjectArtKit(')));
    expect(source, isNot(contains('insertAndGetId')));

    expect(source, contains('GameObjectArtKitKey originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
