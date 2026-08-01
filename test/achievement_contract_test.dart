import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/entity/achievement_category_entity.dart';
import 'package:foxy/entity/achievement_criteria_entity.dart';
import 'package:foxy/entity/achievement_entity.dart';

void main() {
  test('Achievement Entity 精确覆盖 62 个标量物理列', () {
    final json = const AchievementEntity().toJson();
    expect(json.keys, hasLength(62));
    expect(json.keys.first, 'ID');
    expect(json.keys.elementAt(1), 'Faction');
    expect(json.keys.elementAt(2), 'Instance_ID');
    expect(json.keys.elementAt(3), 'Supercedes');
    expect(json.keys.elementAt(20), 'Title_lang_Flags');
    expect(json.keys.elementAt(37), 'Description_lang_Flags');
    expect(json.keys.elementAt(38), 'Category');
    expect(json.keys.elementAt(41), 'Flags');
    expect(json.keys.elementAt(42), 'IconID');
    expect(json.keys.elementAt(59), 'Reward_lang_Flags');
    expect(json.keys.elementAt(60), 'Minimum_criteria');
    expect(json.keys.last, 'Shares_criteria');
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

  test('Achievement Category 与 Criteria 精确覆盖 20/31 个标量列', () {
    final category = const AchievementCategoryEntity().toJson();
    final criteria = const AchievementCriteriaEntity().toJson();
    expect(category.keys, hasLength(20));
    expect(category.keys.first, 'ID');
    expect(category.keys.elementAt(1), 'Parent');
    expect(category.keys.elementAt(18), 'Name_lang_Flags');
    expect(category.keys.last, 'Ui_order');
    expect(criteria.keys, hasLength(31));
    expect(criteria.keys.first, 'ID');
    expect(criteria.keys.elementAt(1), 'Achievement_ID');
    expect(criteria.keys.elementAt(2), 'Type');
    expect(criteria.keys.elementAt(3), 'Asset_ID');
    expect(criteria.keys.elementAt(4), 'Quantity');
    expect(criteria.keys.elementAt(25), 'Description_lang_Flags');
    expect(criteria.keys.elementAt(26), 'Flags');
    expect(criteria.keys.last, 'Ui_order');
    for (final json in [category, criteria]) {
      expect(json.values.whereType<List<Object?>>(), isEmpty);
      expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
    }
  });

  test('Achievement 三张 DBC definitions 使用 3.3.5.12340 精确格式', () {
    final achievement = dbcDefinitionByTable['dbc_achievement']!;
    final category = dbcDefinitionByTable['dbc_achievement_category']!;
    final criteria = dbcDefinitionByTable['dbc_achievement_criteria']!;
    expect(achievement.fileName, 'Achievement.dbc');
    expect(achievement.schema.fields, hasLength(62));
    expect(category.fileName, 'Achievement_Category.dbc');
    expect(category.schema.format, 'nissssssssssssssssii');
    expect(category.schema.fields, hasLength(20));
    expect(criteria.fileName, 'Achievement_Criteria.dbc');
    expect(criteria.schema.format, 'niiiiiiiissssssssssssssssiiiiii');
    expect(criteria.schema.fields, hasLength(31));
    expect(
      requiredDbcTableNames,
      containsAll(['dbc_achievement_category', 'dbc_achievement_criteria']),
    );
  });
}
