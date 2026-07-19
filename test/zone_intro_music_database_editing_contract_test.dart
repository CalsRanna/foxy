import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_zone_intro_music_entity.dart';
import 'package:foxy/entity/zone_intro_music_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const first = 12;
    const same = 12;
    const other = 13;

    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(first, isNot(other));
    expect((const ZoneIntroMusicEntity(id: 12)).id, first);
    expect(const BriefZoneIntroMusicEntity(id: 12).key, first);
  });

  test('ZoneIntroMusic Repository 显式分配创建键并用原始键写入', () {
    final source = File(
      'lib/repository/zone_intro_music_repository.dart',
    ).readAsStringSync();

    expect(source, contains('Future<int> copyZoneIntroMusic('));
    expect(source, contains('Future<void> storeZoneIntroMusic('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeZoneIntroMusic')));
    expect(source, isNot(contains('saveZoneIntroMusic(')));
    expect(source, isNot(contains('insertAndGetId')));

    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
