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

  test('内嵌详情使用 persistedKey、可编辑 ID 和显式 locale 事务', () {
    final viewModel = File(
      'lib/page/gossip_menu/npc_text_view_model.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/gossip_menu/npc_text_view.dart',
    ).readAsStringSync();
    expect(viewModel, contains('persistedKey = signal<int?>'));
    expect(viewModel, contains('final originalKey = persistedKey.value'));
    expect(viewModel, contains('updateNpcText(originalKey, entity)'));
    expect(viewModel, contains('_repository.laconic.transaction'));
    expect(viewModel, contains('persistedKey.value = entity.id'));
    expect(view, isNot(contains('readOnly: true')));
    expect(view, contains('didUpdateWidget'));
  });

  test('BriefNpcText 不暴露写模型 API', () {
    final source = File(
      'lib/entity/brief_npc_text_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
