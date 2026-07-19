import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_creature_display_info_entity.dart';
import 'package:foxy/entity/creature_display_info_key.dart';

void main() {
  test('CreatureDisplayInfoKey 使用 ID 值相等且 Brief 安全解码', () {
    const key = CreatureDisplayInfoKey(id: 7);
    expect(key, const CreatureDisplayInfoKey(id: 7));
    expect(key.hashCode, const CreatureDisplayInfoKey(id: 7).hashCode);
    final brief = BriefCreatureDisplayInfoEntity.fromJson(const {
      'ID': 7,
      'CreatureModelScale': 2,
    });
    expect(brief.key, key);
    expect(brief.creatureModelScale, 2.0);
  });

  test('CreatureDisplayInfo Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/creature_display_info_repository.dart',
    ).readAsStringSync();
    expect(source, contains('CreatureDisplayInfoKey key'));
    expect(source, contains('Future<void> storeCreatureDisplayInfo('));
    expect(source, contains('CreatureDisplayInfoKey originalKey'));
    expect(source, contains('.update(info.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveCreatureDisplayInfo(')));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefCreatureDisplayInfo 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_creature_display_info_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
