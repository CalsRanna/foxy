import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_model_info_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('Brief 安全解码并返回物理 DisplayID 标量', () {
    const key = 7;
    final brief = BriefCreatureModelInfoEntity.fromJson(const {
      'DisplayID': 7,
      'BoundingRadius': 2,
      'CombatReach': 3,
    });
    expect(brief.key, key);
    expect([brief.boundingRadius, brief.combatReach], [2.0, 3.0]);
  });

  test('CreatureModelInfo Repository 预分配并原始键更新完整 candidate', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/creature_model_info_repository.dart',
    );
    expect(
      source,
      contains("displayId: await nextMaxPlusOne(_table, 'DisplayID')"),
    );
    expect(source, contains('Future<void> storeCreatureModelInfo('));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(info.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveCreatureModelInfo(')));
    expect(source, isNot(contains("remove('DisplayID')")));
  });
}
