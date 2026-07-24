import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/game_object_display_info_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const first = 8;
    expect((const GameObjectDisplayInfoEntity(id: 8)).id, first);
    expect(const BriefGameObjectDisplayInfoEntity(id: 8).key, first);
  });

  test('GameObjectDisplayInfo Repository 使用显式创建键与原始更新键', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/game_object_display_info_repository.dart',
    );
    expect(source, contains('Future<int> copyGameObjectDisplayInfo('));
    expect(source, contains('Future<void> storeGameObjectDisplayInfo('));
    expect(source, contains('insert([json])'));
    expect(source, isNot(contains('Future<int> storeGameObjectDisplayInfo')));
    expect(source, isNot(contains('saveGameObjectDisplayInfo(')));
    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(json)'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
