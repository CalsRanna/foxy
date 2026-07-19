import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_creature_movement_info_entity.dart';
import 'package:foxy/entity/creature_movement_info_key.dart';

void main() {
  test('CreatureMovementInfo 使用独立 Brief 和 typed key', () {
    const key = CreatureMovementInfoKey(id: 7);
    expect(key, const CreatureMovementInfoKey(id: 7));
    final brief = BriefCreatureMovementInfoEntity.fromJson(const {
      'ID': 7,
      'SmoothFacingChaseRate': 2,
    });
    expect(brief.key, key);
    expect(brief.smoothFacingChaseRate, 2.0);
  });

  test('CreatureMovementInfo Repository 使用窄查询和原始更新键', () {
    final source = File(
      'lib/repository/creature_movement_info_repository.dart',
    ).readAsStringSync();
    expect(source, contains('Future<List<BriefCreatureMovementInfoEntity>>'));
    expect(source, contains("'SmoothFacingChaseRate'"));
    expect(source, contains('CreatureMovementInfoKey originalKey'));
    expect(source, contains('.update(movementInfo.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveCreatureMovementInfo(')));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('Picker 不再加载 Full CreatureMovementInfo Entity', () {
    final source = File(
      'lib/widget/foxy_entity_picker_delegates.dart',
    ).readAsStringSync();
    expect(
      source,
      contains('FoxyEntityPickerDelegate<BriefCreatureMovementInfoEntity>'),
    );
  });
}
