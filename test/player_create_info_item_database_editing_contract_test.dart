import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_player_create_info_item_entity.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/entity/player_create_info_item_key.dart';

void main() {
  test('起始物品 Key 和 Brief 覆盖 race + class + itemid', () {
    const entity = PlayerCreateInfoItemEntity(race: 1, class_: 2, itemid: 3);
    const key = PlayerCreateInfoItemKey(race: 1, class_: 2, itemId: 3);
    expect(PlayerCreateInfoItemKey.fromEntity(entity), key);
    expect(
      const BriefPlayerCreateInfoItemEntity(race: 1, class_: 2, itemId: 3).key,
      key,
    );
  });

  test('Repository 与编辑器使用旧 Key、完整 candidate、分页 Brief', () {
    final repository = File(
      'lib/repository/player_create_info_item_repository.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/player_create_info/player_create_info_item_collection_editor_view_model.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/player_create_info/player_create_info_item_view.dart',
    ).readAsStringSync();
    expect(repository, contains('PlayerCreateInfoItemKey originalKey'));
    expect(repository, contains('.update(item.toJson())'));
    expect(repository, contains('if (matchedRows == 0)'));
    expect(repository, contains('if (deletedRows == 0)'));
    expect(repository, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(repository, contains('.limit(kPageSize)'));
    expect(repository, isNot(contains('savePlayerCreateInfoItem(')));
    expect(
      viewModel,
      contains('editingKey = signal<PlayerCreateInfoItemKey?>'),
    );
    expect(viewModel, contains('race: raceController.collect()'));
    expect(viewModel, contains('class_: classController.collect()'));
    expect(viewModel, contains('final originalKey = editingKey.value'));
    expect(viewModel, contains('selectedKey.value = key'));
    expect(view, contains('FoxyPagination('));
    expect(view, contains("Text('编辑')"));
    expect(view, isNot(contains('readOnly: true')));
  });
}
