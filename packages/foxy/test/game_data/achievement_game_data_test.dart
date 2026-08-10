import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';

void main() {

  test('Achievement 三张 DBC definitions 使用 3.3.5.12340 精确格式', () {
    final achievement = DbcDefinitions.byTable['dbc_achievement']!;
    final category = DbcDefinitions.byTable['dbc_achievement_category']!;
    final criteria = DbcDefinitions.byTable['dbc_achievement_criteria']!;
    expect(achievement.fileName, 'Achievement.dbc');
    expect(achievement.schema.fields, hasLength(62));
    expect(category.fileName, 'Achievement_Category.dbc');
    expect(category.schema.format, 'nissssssssssssssssii');
    expect(category.schema.fields, hasLength(20));
    expect(criteria.fileName, 'Achievement_Criteria.dbc');
    expect(criteria.schema.format, 'niiiiiiiissssssssssssssssiiiiii');
    expect(criteria.schema.fields, hasLength(31));
    expect(
      DbcDefinitions.requiredTableNames,
      containsAll(['dbc_achievement_category', 'dbc_achievement_criteria']),
    );
  });
}
