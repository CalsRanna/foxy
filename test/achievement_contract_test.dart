import 'support/entity_validation_test_extensions.dart';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/achievement_constants.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/entity/achievement_category_entity.dart';
import 'package:foxy/entity/achievement_criteria_entity.dart';
import 'package:foxy/entity/achievement_entity.dart';
import 'support/local_dart_library_source.dart';

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

  test('Achievement 使用专属阵营、Flags、signed locale flags 和 smallint ID', () {
    expect(kAchievementFactionOptions, {-1: '双方', 0: '部落', 1: '联盟'});
    expect(kAchievementFlagOptions, hasLength(10));
    expect(
      kAchievementFlagOptions.fold<int>(0, (mask, flag) => mask | flag.value),
      kAchievementKnownFlagMask,
    );
    expect(
      const AchievementEntity(
        id: 1,
        category: 1,
        rewardLangFlags: -16842260,
      ).validate,
      returnsNormally,
    );
    expect(
      () => const AchievementEntity(id: 65536, category: 1).validate(),
      throwsArgumentError,
    );
    expect(
      () => const AchievementEntity(id: 1, category: 1, faction: 2).validate(),
      throwsArgumentError,
    );
    expect(
      () =>
          const AchievementEntity(id: 1, category: 1, flags: 0x400).validate(),
      throwsArgumentError,
    );
    expect(
      () => const AchievementEntity(
        id: 1,
        category: 1,
        sharesCriteria: 1,
      ).validate(),
      throwsArgumentError,
    );
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

  test('Category 与 Criteria 值域按 AzerothCore DBCEnums 校验', () {
    expect(
      const AchievementCategoryEntity(
        id: 1,
        parent: -1,
        nameLangFlags: -1,
      ).validate,
      returnsNormally,
    );
    expect(
      () => const AchievementCategoryEntity(id: 1, parent: 1).validate(),
      throwsArgumentError,
    );
    expect(
      const AchievementCriteriaEntity(
        id: 1,
        achievementId: 2,
        type: 123,
        startEvent: 13,
        failEvent: 10,
        flags: 0x3f,
        timerStartEvent: 2,
        timerAssetId: 10,
        timerTime: 30,
      ).validate,
      returnsNormally,
    );
    expect(
      () => const AchievementCriteriaEntity(
        id: 1,
        achievementId: 2,
        type: 2,
      ).validate(),
      throwsArgumentError,
    );
    expect(
      () => const AchievementCriteriaEntity(
        id: 65536,
        achievementId: 2,
      ).validate(),
      throwsArgumentError,
    );
    expect(kAchievementCriteriaStoredTypes, containsAll([118, 120, 123]));
    expect(
      () => const AchievementCriteriaEntity(
        id: 1,
        achievementId: 2,
        flags: 0x40,
      ).validate(),
      throwsArgumentError,
    );
  });

  test('详情页四列等宽且使用各字段准确控件', () {
    final view = File(
      'lib/page/achievement/achievement_view.dart',
    ).readAsStringSync();
    expect(view, isNot(contains('flex:')));
    expect(view, contains('kAchievementFactionOptions'));
    expect(view, contains('kAchievementFlagOptions'));
    expect(view, contains('FoxyEntityPickerDelegates.map'));
    expect(view, contains('FoxyEntityPickerDelegates.achievementCategory'));
    expect(view, contains('FoxyEntityPickerDelegates.spellIcon'));
    expect(
      'FoxyEntityPickerDelegates.achievement'.allMatches(view),
      hasLength(3),
    );
    expect('Row('.allMatches(view), hasLength(7));
    expect('Expanded('.allMatches(view), hasLength(24));
    expect(view, isNot(contains('readOnly: true')));
    expect('viewModel.persistedKey.value'.allMatches(view), hasLength(4));
  });

  test('Repository 使用原始键、完整 candidate 和单表边界', () {
    final repository = readLocalDartLibrarySource(
      'lib/repository/achievement_repository.dart',
    );
    final criteriaRepository = readLocalDartLibrarySource(
      'lib/repository/achievement_criteria_repository.dart',
    );
    final viewModel = File(
      'lib/page/achievement/achievement_detail_view_model.dart',
    ).readAsStringSync();
    expect(repository, isNot(contains('.validate()')));
    expect(viewModel, contains('validateAchievementFields(candidate);'));
    expect(repository, contains('int originalKey'));
    expect(repository, contains('.update(achievement.toJson())'));
    expect(repository, contains('matchedRows == 0'));
    expect(repository, contains('deletedRows == 0'));
    expect(repository, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(repository, isNot(contains("table('foxy.dbc_map')")));
    expect(
      repository,
      isNot(contains("table('foxy.dbc_achievement_category')")),
    );
    expect(repository, isNot(contains("table('foxy.dbc_spell_icon')")));
    expect(repository, isNot(contains("remove('ID')")));
    expect(repository, isNot(contains(".table('achievement_reward')")));
    expect(repository, isNot(contains('acore_characters')));
    expect(criteriaRepository, isNot(contains('acore_characters')));
    expect(
      criteriaRepository,
      isNot(contains(".table('achievement_criteria_data')")),
    );
    expect(criteriaRepository, contains('int key'));
    expect(criteriaRepository, contains('deletedRows == 0'));
    expect(repository, contains(".orderBy('ID')"));
    expect(viewModel, contains('signal<int?>(null)'));
    expect(viewModel, contains('final originalKey = persistedKey.value'));
    expect(viewModel, contains('updateAchievement(originalKey, candidate)'));
    expect(viewModel, contains('persistedKey.value = candidate.id'));
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
