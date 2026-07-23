import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_player_create_info_spell_custom_entity.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/entity/player_create_info_spell_custom_key.dart';

void main() {
  test('自定义法术 Key 和 Brief 覆盖 racemask + classmask + Spell', () {
    const entity = PlayerCreateInfoSpellCustomEntity(
      racemask: 1,
      classmask: 2,
      spell: 3,
    );
    const key = PlayerCreateInfoSpellCustomKey(
      raceMask: 1,
      classMask: 2,
      spell: 3,
    );
    expect(PlayerCreateInfoSpellCustomKey.fromEntity(entity), key);
    expect(
      const BriefPlayerCreateInfoSpellCustomEntity(
        raceMask: 1,
        classMask: 2,
        spell: 3,
      ).key,
      key,
    );
  });

  test('Repository 与编辑器使用旧 Key、完整 candidate、分页 Brief', () {
    final repository = File(
      'lib/repository/player_create_info_spell_custom_repository.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/player_create_info/player_create_info_spell_custom_collection_editor_view_model.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/player_create_info/player_create_info_spell_custom_view.dart',
    ).readAsStringSync();
    expect(repository, contains('PlayerCreateInfoSpellCustomKey originalKey'));
    expect(repository, contains('.update(entity.toJson())'));
    expect(repository, contains('if (matchedRows == 0)'));
    expect(repository, contains('if (deletedRows == 0)'));
    expect(repository, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(repository, contains('.limit(kPageSize)'));
    expect(repository, isNot(contains('savePlayerCreateInfoSpellCustom(')));
    expect(
      viewModel,
      contains('editingKey = signal<PlayerCreateInfoSpellCustomKey?>'),
    );
    expect(viewModel, contains('final originalKey = editingKey.value'));
    expect(viewModel, contains('selectedKey.value = key'));
    expect(view, contains('FoxyPagination('));
    expect(view, contains("Text('编辑')"));
    expect(view, isNot(contains('readOnly: true')));
  });
}
