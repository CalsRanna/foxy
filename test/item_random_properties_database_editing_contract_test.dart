import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/item_random_properties_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect(const BriefItemRandomPropertiesEntity(id: 7).key, key);
  });

  test('ItemRandomProperties Repository 使用显式创建键与原始更新键', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/item_random_properties_repository.dart',
    );
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storeItemRandomProperties('));
    expect(source, contains('int originalKey'));
    expect(source, contains(').update(json)'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveItemRandomPropertiesLocales('));
    expect(source, isNot(contains('saveItemRandomProperty(')));
    expect(source, isNot(contains("remove('ID')")));
  });
}
