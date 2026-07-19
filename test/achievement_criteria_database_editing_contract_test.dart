import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/achievement_criteria_key.dart';
import 'package:foxy/entity/brief_achievement_criteria_entity.dart';

void main() {
  test('AchievementCriteriaKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = AchievementCriteriaKey(id: 7);
    expect(key, const AchievementCriteriaKey(id: 7));
    expect(key.hashCode, const AchievementCriteriaKey(id: 7).hashCode);
    expect(const BriefAchievementCriteriaEntity(id: 7).key, key);
  });

  test('AchievementCriteria Repository 使用显式键和单表边界', () {
    final source = File(
      'lib/repository/achievement_criteria_repository.dart',
    ).readAsStringSync();
    expect(source, contains('AchievementCriteriaKey key'));
    expect(source, contains('Future<void> storeAchievementCriterion('));
    expect(source, contains('AchievementCriteriaKey originalKey'));
    expect(source, contains('.update(criterion.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveAchievementCriteriaLocales('));
    expect(source, isNot(contains('saveAchievementCriterion(')));
    expect(source, isNot(contains("table('foxy.dbc_achievement')")));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefAchievementCriteria 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_achievement_criteria_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
