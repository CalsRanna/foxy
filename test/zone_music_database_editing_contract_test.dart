import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/zone_music_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const first = 4;
    const same = 4;
    const other = 5;

    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(first, isNot(other));
    expect((const ZoneMusicEntity(id: 4)).id, first);
    expect(const BriefZoneMusicEntity(id: 4).key, first);
  });

  test('ZoneMusic Repository 显式分配创建键并用原始键写入', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/zone_music_repository.dart',
    );

    expect(source, contains('Future<int> copyZoneMusic('));
    expect(source, contains('Future<void> storeZoneMusic('));
    expect(source, contains('insert([json])'));
    expect(source, isNot(contains('Future<int> storeZoneMusic')));
    expect(source, isNot(contains('saveZoneMusic(')));
    expect(source, isNot(contains('insertAndGetId')));

    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(json)'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
