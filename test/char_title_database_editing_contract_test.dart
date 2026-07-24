import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/char_title_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect(const BriefCharTitleEntity(id: 7).key, key);
  });

  test('CharTitle Repository 使用显式键并保留本表 locale API', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/char_title_repository.dart',
    );
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storeCharTitle('));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(json)'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveCharTitleLocales('));
    expect(source, isNot(contains('saveCharTitle(CharTitleEntity')));
    expect(source, isNot(contains("remove('ID')")));
  });
}
