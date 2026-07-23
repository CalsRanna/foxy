import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_player_create_info_skill_entity.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/entity/player_create_info_skill_key.dart';

void main() {
  test('出生技能 Key 和 Brief 覆盖 raceMask + classMask + skill', () {
    const entity = PlayerCreateInfoSkillEntity(
      raceMask: 1,
      classMask: 2,
      skill: 3,
    );
    const key = PlayerCreateInfoSkillKey(raceMask: 1, classMask: 2, skill: 3);
    expect(PlayerCreateInfoSkillKey.fromEntity(entity), key);
    expect(
      const BriefPlayerCreateInfoSkillEntity(
        raceMask: 1,
        classMask: 2,
        skill: 3,
      ).key,
      key,
    );
  });

  test('Repository 与编辑器使用旧 Key、完整 candidate、分页 Brief', () {
    final repository = File(
      'lib/repository/player_create_info_skill_repository.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/player_create_info/player_create_info_skill_collection_editor_view_model.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/player_create_info/player_create_info_skill_view.dart',
    ).readAsStringSync();
    expect(repository, contains('PlayerCreateInfoSkillKey originalKey'));
    expect(repository, contains('.update(entity.toJson())'));
    expect(repository, contains('if (matchedRows == 0)'));
    expect(repository, contains('if (deletedRows == 0)'));
    expect(repository, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(repository, contains('.limit(kPageSize)'));
    expect(repository, isNot(contains('savePlayerCreateInfoSkill(')));
    expect(
      viewModel,
      contains('editingKey = signal<PlayerCreateInfoSkillKey?>'),
    );
    expect(viewModel, contains('final originalKey = editingKey.value'));
    expect(viewModel, contains('selectedKey.value = key'));
    expect(view, contains('FoxyPagination('));
    expect(view, isNot(contains('readOnly: true')));
  });
}
