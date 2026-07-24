import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/spell_icon_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const first = 71;
    expect((const SpellIconEntity(id: 71)).id, first);
    expect(const BriefSpellIconEntity(id: 71).key, first);
  });

  test('SpellIcon Repository 使用显式创建键与原始更新键', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/spell_icon_repository.dart',
    );
    expect(source, contains('Future<int> copySpellIcon('));
    expect(source, contains('Future<void> storeSpellIcon('));
    expect(source, contains('if (icon.id <= 0)'));
    expect(source, contains('insert([icon.toJson()])'));
    expect(source, isNot(contains('Future<int> storeSpellIcon')));
    expect(source, isNot(contains('saveSpellIcon(')));
    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(icon.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
