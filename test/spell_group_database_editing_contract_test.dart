import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/spell_group_entity.dart';

void main() {
  test('SpellGroupKey 和 Brief 覆盖 id + spell_id', () {
    const key = SpellGroupKey(id: 1001, spellId: 20);
    expect(
      SpellGroupKey.fromEntity(const SpellGroupEntity(id: 1001, spellId: 20)),
      key,
    );
    expect(const BriefSpellGroupEntity(id: 1001, spellId: 20).key, key);
    expect(key, isNot(const SpellGroupKey(id: 1001, spellId: 21)));
  });

  test('Repository 使用完整旧 key、完整 candidate 和写入结果', () {
    final source = File(
      'lib/repository/spell_group_repository.dart',
    ).readAsStringSync();
    expect(source, contains('SpellGroupKey originalKey'));
    expect(source, contains('.update(data.toJson())'));
    expect(source, contains("where('id', key.id)"));
    expect(source, contains("where('spell_id', key.spellId)"));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveSpellGroup(')));
  });

  test('内嵌编辑器使用 Brief、editingKey、分页且两个键都可编辑', () {
    final repository = File(
      'lib/repository/spell_group_repository.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/spell/spell_group_collection_editor_view_model.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/spell/spell_group_view.dart',
    ).readAsStringSync();
    expect(repository, contains('Future<List<BriefSpellGroupEntity>>'));
    expect(repository, contains('.limit(kPageSize)'));
    expect(viewModel, contains('editingKey = signal<SpellGroupKey?>'));
    expect(viewModel, contains('final originalKey = editingKey.value'));
    expect(viewModel, contains('spellId: spellIdController.collect()'));
    expect(viewModel, contains('selectedKey.value = key'));
    expect(view, contains('FoxyPagination('));
    expect(view, isNot(contains('readOnly: true')));
  });
}
