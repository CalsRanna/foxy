import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_player_create_info_action_entity.dart';
import 'package:foxy/entity/player_create_info_action_key.dart';
import 'package:foxy/entity/player_create_info_action_entity.dart';

void main() {
  test('动作 Key 和 Brief 覆盖 race + class + button', () {
    const entity = PlayerCreateInfoActionEntity(race: 1, class_: 2, button: 3);
    const key = PlayerCreateInfoActionKey(race: 1, class_: 2, button: 3);
    expect(PlayerCreateInfoActionKey.fromEntity(entity), key);
    expect(
      const BriefPlayerCreateInfoActionEntity(
        race: 1,
        class_: 2,
        button: 3,
      ).key,
      key,
    );
    expect(
      key,
      isNot(const PlayerCreateInfoActionKey(race: 1, class_: 2, button: 4)),
    );
  });

  test('Repository 与内嵌编辑器使用旧 Key、完整 candidate 和分页 Brief', () {
    final repository = File(
      'lib/repository/player_create_info_action_repository.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/player_create_info/player_create_info_action_collection_editor_view_model.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/player_create_info/player_create_info_action_view.dart',
    ).readAsStringSync();
    expect(repository, contains('PlayerCreateInfoActionKey originalKey'));
    expect(repository, contains('.update(action.toJson())'));
    expect(repository, contains('if (matchedRows == 0)'));
    expect(repository, contains('if (deletedRows == 0)'));
    expect(repository, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(repository, contains('.limit(kPageSize)'));
    expect(repository, isNot(contains('savePlayerCreateInfoAction(')));
    expect(
      viewModel,
      contains('editingKey = signal<PlayerCreateInfoActionKey?>'),
    );
    expect(viewModel, contains('race: raceController.collect()'));
    expect(viewModel, contains('class_: classController.collect()'));
    expect(viewModel, contains('final originalKey = editingKey.value'));
    expect(viewModel, contains('selectedKey.value = key'));
    expect(view, contains('FoxyPagination('));
    expect(view, isNot(contains('readOnly: true')));
    expect(view, isNot(contains('readOnly: isEditing')));
  });
}
