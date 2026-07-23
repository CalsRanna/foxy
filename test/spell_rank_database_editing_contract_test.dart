import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_spell_rank_entity.dart';
import 'package:foxy/entity/spell_rank_entity.dart';
import 'package:foxy/entity/spell_rank_key.dart';

void main() {
  test('SpellRankKey 和 Brief 覆盖 first_spell_id + rank', () {
    const key = SpellRankKey(firstSpellId: 1001, rank: 3);
    expect(
      SpellRankKey.fromEntity(
        const SpellRankEntity(firstSpellId: 1001, spellId: 1003, rank: 3),
      ),
      key,
    );
    expect(
      const BriefSpellRankEntity(
        firstSpellId: 1001,
        spellId: 1003,
        rank: 3,
      ).key,
      key,
    );
    expect(key, isNot(const SpellRankKey(firstSpellId: 1001, rank: 4)));
  });

  test('Repository 使用完整旧 key、完整 candidate 和写入结果', () {
    final source = File(
      'lib/repository/spell_rank_repository.dart',
    ).readAsStringSync();
    expect(source, contains('SpellRankKey originalKey'));
    expect(source, contains('.update(_writeJson(data))'));
    expect(source, contains("where('first_spell_id', key.firstSpellId)"));
    expect(source, contains("where('`rank`', key.rank)"));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveSpellRank(')));
  });

  test('内嵌编辑器使用 Brief、editingKey、分页且所有物理字段可编辑', () {
    final repository = File(
      'lib/repository/spell_rank_repository.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/spell/spell_rank_collection_editor_view_model.dart',
    ).readAsStringSync();
    final view = File('lib/page/spell/spell_rank_view.dart').readAsStringSync();
    expect(repository, contains('Future<List<BriefSpellRankEntity>>'));
    expect(repository, contains('.limit(kPageSize)'));
    expect(viewModel, contains('editingKey = signal<SpellRankKey?>'));
    expect(viewModel, contains('final originalKey = editingKey.value'));
    expect(viewModel, contains('selectedKey.value = key'));
    expect(viewModel, contains('rank: rankController.collect()'));
    expect(view, contains('FoxyPagination('));
    expect(view, isNot(contains('readOnly: true')));
  });

  test('BriefSpellRank 不暴露写模型 API', () {
    final source = File(
      'lib/entity/brief_spell_rank_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
