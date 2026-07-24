import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/game_object_art_kit_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const first = 2;
    const same = 2;

    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect((const GameObjectArtKitEntity(id: 2)).id, first);
    expect(const BriefGameObjectArtKitEntity(id: 2).key, first);
  });

  test('GameObjectArtKit Repository 使用显式创建键与原始更新键', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/game_object_art_kit_repository.dart',
    );

    expect(source, contains('Future<int> copyGameObjectArtKit('));
    expect(source, contains('Future<void> storeGameObjectArtKit('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeGameObjectArtKit')));
    expect(source, isNot(contains('saveGameObjectArtKit(')));
    expect(source, isNot(contains('insertAndGetId')));

    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
