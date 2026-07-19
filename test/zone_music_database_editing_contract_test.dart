import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_zone_music_entity.dart';
import 'package:foxy/entity/zone_music_entity.dart';
import 'package:foxy/entity/zone_music_key.dart';

void main() {
  test('ZoneMusicKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const first = ZoneMusicKey(id: 4);
    const same = ZoneMusicKey(id: 4);
    const other = ZoneMusicKey(id: 5);

    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(first, isNot(other));
    expect(ZoneMusicKey.fromEntity(const ZoneMusicEntity(id: 4)), first);
    expect(const BriefZoneMusicEntity(id: 4).key, first);
  });

  test('ZoneMusic Repository 显式分配创建键并用原始键写入', () {
    final source = File(
      'lib/repository/zone_music_repository.dart',
    ).readAsStringSync();

    expect(source, contains('Future<ZoneMusicKey> copyZoneMusic('));
    expect(source, contains('Future<void> storeZoneMusic('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeZoneMusic')));
    expect(source, isNot(contains('saveZoneMusic(')));
    expect(source, isNot(contains('insertAndGetId')));

    expect(source, contains('ZoneMusicKey originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
