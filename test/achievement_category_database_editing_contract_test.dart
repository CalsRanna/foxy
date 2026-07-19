import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/achievement_category_key.dart';
import 'package:foxy/entity/brief_achievement_category_entity.dart';

void main() {
  test('AchievementCategoryKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = AchievementCategoryKey(id: 7);
    expect(key, const AchievementCategoryKey(id: 7));
    expect(key.hashCode, const AchievementCategoryKey(id: 7).hashCode);
    expect(const BriefAchievementCategoryEntity(id: 7).key, key);
  });

  test('AchievementCategory Repository 使用显式键和单表边界', () {
    final source = File(
      'lib/repository/achievement_category_repository.dart',
    ).readAsStringSync();
    expect(source, contains('AchievementCategoryKey key'));
    expect(source, contains('Future<void> storeAchievementCategory('));
    expect(source, contains('AchievementCategoryKey originalKey'));
    expect(source, contains('.update(category.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveAchievementCategoryLocales('));
    expect(source, isNot(contains('saveAchievementCategory(')));
    expect(source, isNot(contains("table('foxy.dbc_achievement')")));
    expect(source, isNot(contains("where('Parent'")));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefAchievementCategory 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_achievement_category_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
