import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_achievement_category_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect(const BriefAchievementCategoryEntity(id: 7).key, key);
  });

  test('AchievementCategory Repository 使用显式键和单表边界', () {
    final source = File(
      'lib/repository/achievement_category_repository.dart',
    ).readAsStringSync();
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storeAchievementCategory('));
    expect(source, contains('int originalKey'));
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
}
