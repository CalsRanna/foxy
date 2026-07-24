import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_map_info_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect(const BriefMapInfoEntity(id: 7).key, key);
  });

  test('MapInfo Repository 使用显式键并保留本表 locale API', () {
    final source = File(
      'lib/repository/map_info_repository.dart',
    ).readAsStringSync();
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storeMapInfo('));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(map.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveMapInfoLocales('));
    expect(source, isNot(contains('saveMapInfo(MapInfoEntity')));
    expect(source, isNot(contains("remove('ID')")));
  });
}
