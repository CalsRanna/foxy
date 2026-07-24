import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/spell_linked_spell_entity.dart';

void main() {
  test('SpellLinkedSpellKey 覆盖物理 UNIQUE 三列并实现值相等', () {
    const key = SpellLinkedSpellKey(spellTrigger: 10, spellEffect: 20, type: 2);
    expect(
      SpellLinkedSpellKey.fromEntity(
        const SpellLinkedSpellEntity(
          spellTrigger: 10,
          spellEffect: 20,
          type: 2,
        ),
      ),
      key,
    );
    expect(
      const BriefSpellLinkedSpellEntity(
        spellTrigger: 10,
        spellEffect: 20,
        type: 2,
      ).key,
      key,
    );
    expect(
      key,
      isNot(
        const SpellLinkedSpellKey(spellTrigger: 10, spellEffect: 20, type: 1),
      ),
    );
  });

  test('Repository 使用完整旧 UNIQUE key、完整 candidate 和写入结果', () {
    final source = File(
      'lib/repository/spell_linked_spell_repository.dart',
    ).readAsStringSync();
    expect(source, contains('SpellLinkedSpellKey originalKey'));
    expect(source, contains('.update(data.toJson())'));
    expect(source, contains("where('spell_trigger', key.spellTrigger)"));
    expect(source, contains("where('spell_effect', key.spellEffect)"));
    expect(source, contains("where('type', key.type)"));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveSpellLinkedSpell(')));
  });

  test('内嵌编辑器使用 Brief、editingKey、分页和统一 persist', () {
    final repository = File(
      'lib/repository/spell_linked_spell_repository.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/spell/spell_linked_spell_collection_editor_view_model.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/spell/spell_linked_spell_view.dart',
    ).readAsStringSync();
    expect(repository, contains('Future<List<BriefSpellLinkedSpellEntity>>'));
    expect(repository, contains('.limit(kPageSize)'));
    expect(viewModel, contains('editingKey = signal<SpellLinkedSpellKey?>'));
    expect(viewModel, contains('final originalKey = editingKey.value'));
    expect(viewModel, contains('selectedKey.value = key'));
    expect(viewModel, contains('countSpellLinkedSpells(parent)'));
    expect(view, contains('FoxyPagination('));
  });
}
