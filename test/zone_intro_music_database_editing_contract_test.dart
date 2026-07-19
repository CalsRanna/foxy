import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_zone_intro_music_entity.dart';
import 'package:foxy/entity/zone_intro_music_entity.dart';
import 'package:foxy/entity/zone_intro_music_key.dart';

void main() {
  test('ZoneIntroMusicKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const first = ZoneIntroMusicKey(id: 12);
    const same = ZoneIntroMusicKey(id: 12);
    const other = ZoneIntroMusicKey(id: 13);

    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(first, isNot(other));
    expect(
      ZoneIntroMusicKey.fromEntity(const ZoneIntroMusicEntity(id: 12)),
      first,
    );
    expect(const BriefZoneIntroMusicEntity(id: 12).key, first);
  });

  test('ZoneIntroMusic Repository 显式分配创建键并用原始键写入', () {
    final source = File(
      'lib/repository/zone_intro_music_repository.dart',
    ).readAsStringSync();

    expect(source, contains('Future<ZoneIntroMusicKey> copyZoneIntroMusic('));
    expect(source, contains('Future<void> storeZoneIntroMusic('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeZoneIntroMusic')));
    expect(source, isNot(contains('saveZoneIntroMusic(')));
    expect(source, isNot(contains('insertAndGetId')));

    expect(source, contains('ZoneIntroMusicKey originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
