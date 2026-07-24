import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/light_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const first = 9;
    const same = 9;

    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect((const LightEntity(id: 9)).id, first);
    expect(const BriefLightEntity(id: 9).key, first);
  });

  test('Light Repository 使用显式创建键与原始更新键', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/light_repository.dart',
    );

    expect(source, contains('Future<int> copyLight('));
    expect(source, contains('Future<void> storeLight('));
    expect(source, contains('insert([json])'));
    expect(source, isNot(contains('Future<int> storeLight')));
    expect(source, isNot(contains('saveLight(')));
    expect(source, isNot(contains('insertAndGetId')));

    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(json)'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
