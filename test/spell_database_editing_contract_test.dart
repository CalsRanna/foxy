import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_spell_entity.dart';
import 'package:foxy/entity/spell_entity.dart';
import 'package:foxy/entity/spell_key.dart';

void main() {
  test('SpellKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = SpellKey(id: 7);
    expect(key, const SpellKey(id: 7));
    expect(key.hashCode, const SpellKey(id: 7).hashCode);
    expect(SpellKey.fromEntity(const SpellEntity(id: 7)), key);
    expect(const BriefSpellEntity(id: 7).key, key);
  });

  test('Repository 使用原 key、完整 candidate 和 DBC 单表写入边界', () {
    final source = File(
      'lib/repository/spell_repository.dart',
    ).readAsStringSync();
    expect(source, contains('SpellKey originalKey'));
    expect(source, contains(').update(spell.toJson())'));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveSpell(')));
    expect(source, isNot(contains("json.remove('ID')")));
  });

  test('详情路由只携带 typed key，主键可编辑且 locale 使用持久化 ID', () {
    final page = File(
      'lib/page/spell/spell_detail_page.dart',
    ).readAsStringSync();
    final list = File('lib/page/spell/spell_list_page.dart').readAsStringSync();
    final view = File('lib/page/spell/spell_view.dart').readAsStringSync();
    final viewModel = File(
      'lib/page/spell/spell_detail_view_model.dart',
    ).readAsStringSync();
    expect(page, contains('final SpellKey? spellKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('templates[row].key'));
    expect(view, contains('vm.persistedKey.value?.id'));
    expect(view, isNot(contains('readOnly: true')));
    expect(viewModel, contains('id: idController.collect()'));
    expect(viewModel, contains('final originalKey = persistedKey.value'));
  });

  test('BriefSpell 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_spell_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
