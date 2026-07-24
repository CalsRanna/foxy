import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/achievement_criteria_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect(const BriefAchievementCriteriaEntity(id: 7).key, key);
  });

  test('AchievementCriteria Repository 使用显式键和单表边界', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/achievement_criteria_repository.dart',
    );
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storeAchievementCriteria('));
    expect(source, contains('int originalKey'));
    expect(source, contains(').update(json)'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveAchievementCriteriaLocales('));
    expect(source, isNot(contains('saveAchievementCriterion(')));
    expect(source, isNot(contains("table('foxy.dbc_achievement')")));
    expect(source, isNot(contains("remove('ID')")));
  });
}
