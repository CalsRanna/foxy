import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_map_info_entity.dart';
import 'package:foxy/entity/map_info_key.dart';

void main() {
  test('MapInfoKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = MapInfoKey(id: 7);
    expect(key, const MapInfoKey(id: 7));
    expect(key.hashCode, const MapInfoKey(id: 7).hashCode);
    expect(const BriefMapInfoEntity(id: 7).key, key);
  });

  test('MapInfo Repository 使用显式键并保留本表 locale API', () {
    final source = File(
      'lib/repository/map_info_repository.dart',
    ).readAsStringSync();
    expect(source, contains('MapInfoKey key'));
    expect(source, contains('Future<void> storeMapInfo('));
    expect(source, contains('MapInfoKey originalKey'));
    expect(source, contains('.update(map.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveMapInfoLocales('));
    expect(source, isNot(contains('saveMapInfo(MapInfoEntity')));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefMapInfo 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_map_info_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
