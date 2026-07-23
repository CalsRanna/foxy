import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_spell_area_entity.dart';
import 'package:foxy/entity/spell_area_entity.dart';
import 'package:foxy/entity/spell_area_key.dart';

void main() {
  test('SpellAreaKey 和 Brief 覆盖六列物理主键', () {
    const entity = SpellAreaEntity(
      spell: 1,
      area: 2,
      questStart: 3,
      auraSpell: 4,
      racemask: 5,
      gender: 2,
    );
    const key = SpellAreaKey(
      spell: 1,
      area: 2,
      questStart: 3,
      auraSpell: 4,
      racemask: 5,
      gender: 2,
    );
    expect(SpellAreaKey.fromEntity(entity), key);
    expect(
      const BriefSpellAreaEntity(
        spell: 1,
        area: 2,
        questStart: 3,
        auraSpell: 4,
        racemask: 5,
        gender: 2,
      ).key,
      key,
    );
    expect(
      key,
      isNot(
        const SpellAreaKey(
          spell: 1,
          area: 2,
          questStart: 3,
          auraSpell: 4,
          racemask: 5,
          gender: 1,
        ),
      ),
    );
  });

  test('Repository 使用完整旧 key、完整 candidate 和写入结果', () {
    final source = File(
      'lib/repository/spell_area_repository.dart',
    ).readAsStringSync();
    for (final condition in [
      "where('spell', key.spell)",
      "where('area', key.area)",
      "where('quest_start', key.questStart)",
      "where('aura_spell', key.auraSpell)",
      "where('racemask', key.racemask)",
      "where('gender', key.gender)",
    ]) {
      expect(source, contains(condition));
    }
    expect(source, contains('SpellAreaKey originalKey'));
    expect(source, contains('.update(data.toJson())'));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveSpellArea(')));
  });

  test('内嵌编辑器使用 Brief、editingKey、分页且法术键可编辑', () {
    final repository = File(
      'lib/repository/spell_area_repository.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/spell/spell_area_collection_editor_view_model.dart',
    ).readAsStringSync();
    final view = File('lib/page/spell/spell_area_view.dart').readAsStringSync();
    expect(repository, contains('Future<List<BriefSpellAreaEntity>>'));
    expect(repository, contains('.limit(kPageSize)'));
    expect(viewModel, contains('editingKey = signal<SpellAreaKey?>'));
    expect(viewModel, contains('spell: spellIdController.collect()'));
    expect(viewModel, contains('final originalKey = editingKey.value'));
    expect(viewModel, contains('selectedKey.value = key'));
    expect(view, contains('FoxyPagination('));
    expect(view, isNot(contains('readOnly: true')));
  });
}
