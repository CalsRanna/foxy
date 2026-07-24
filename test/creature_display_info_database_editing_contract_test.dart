import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_display_info_entity.dart';

void main() {
  test('Brief 安全解码并返回物理 ID 标量', () {
    const key = 7;
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
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storeCreatureDisplayInfo('));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(info.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveCreatureDisplayInfo(')));
    expect(source, isNot(contains("remove('ID')")));
  });
}
