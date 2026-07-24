import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/spell_range_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('Brief 安全解码并返回物理 ID 标量', () {
    const first = 91;
    expect((const SpellRangeEntity(id: 91)).id, first);
    final brief = BriefSpellRangeEntity.fromJson({
      'ID': 91,
      'RangeMin0': 1,
      'RangeMax0': 2,
    });
    expect(brief.rangeMin0, 1.0);
    expect(brief.rangeMax0, 2.0);
    expect(brief.key, first);
  });

  test('SpellRange Repository 使用显式创建键与原始更新键', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/spell_range_repository.dart',
    );
    expect(source, contains('Future<int> copySpellRange('));
    expect(source, contains('Future<void> storeSpellRange('));
    expect(source, contains('if (range.id <= 0)'));
    expect(source, contains('insert([range.toJson()])'));
    expect(source, isNot(contains('Future<int> storeSpellRange')));
    expect(source, isNot(contains('saveSpellRange(')));
    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(range.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('storeDbcLocaleField(id, field, locales)'));
  });
}
