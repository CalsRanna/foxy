import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_npc_text_entity.dart';
import 'package:foxy/entity/npc_text_entity.dart';

void main() {
  test('int 和 Brief 覆盖 ID', () {
    const key = 33;
    expect((const NpcTextEntity(id: 33)).id, key);
    expect(const BriefNpcTextEntity(id: 33).key, key);
  });

  test('Repository 使用旧 key、完整 candidate 和写入结果', () {
    final source = File(
      'lib/repository/npc_text_repository.dart',
    ).readAsStringSync();
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(npcText.toJson())'));
    expect(source, contains("where('ID', key)"));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('if (npcText.id <= 0)'));
    expect(source, isNot(contains('saveNpcText(')));
    expect(source, isNot(contains('Future<int> storeNpcText')));
  });

  test('单行编辑器使用 editingKey、可编辑 ID 和具体事务 UseCase', () {
    final viewModel = File(
      'lib/page/gossip_menu/npc_text_single_editor_view_model.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/gossip_menu/npc_text_view.dart',
    ).readAsStringSync();
    final useCase = File(
      'lib/use_case/gossip_menu/save_npc_text_use_case.dart',
    ).readAsStringSync();
    expect(viewModel, contains('editingKey = signal<int?>'));
    expect(viewModel, contains('final originalKey = editingKey.value'));
    expect(viewModel, contains('_persistUseCase.execute('));
    expect(viewModel, isNot(contains('.transaction')));
    expect(viewModel, contains('editingKey.value = result.persistedKey'));
    expect(useCase, contains('_transaction.execute('));
    expect(useCase, contains('updateNpcText(originalKey, candidate)'));
    expect(view, isNot(contains('readOnly: true')));
    expect(view, contains('didUpdateWidget'));
  });
}
