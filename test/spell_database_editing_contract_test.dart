import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/spell_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect((const SpellEntity(id: 7)).id, key);
    expect(const BriefSpellEntity(id: 7).key, key);
  });

  test('Repository 使用原 key、完整 candidate 和 DBC 单表写入边界', () {
    final source = File(
      'lib/repository/spell_repository.dart',
    ).readAsStringSync();
    expect(source, contains('int originalKey'));
    expect(source, contains(').update(spell.toJson())'));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveSpell(')));
    expect(source, isNot(contains("json.remove('ID')")));
  });

  test('详情路由只携带标量 key，主键可编辑且 locale 使用持久化 ID', () {
    final page = File(
      'lib/page/spell/spell_detail_page.dart',
    ).readAsStringSync();
    final list = File('lib/page/spell/spell_list_page.dart').readAsStringSync();
    final view = File('lib/page/spell/spell_view.dart').readAsStringSync();
    final viewModel = File(
      'lib/page/spell/spell_detail_view_model.dart',
    ).readAsStringSync();
    expect(page, contains('final int? spellKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('templates[row].key'));
    expect(view, contains('vm.persistedKey.value'));
    expect(view, isNot(contains('readOnly: true')));
    expect(viewModel, contains('id: idController.collect()'));
    expect(viewModel, contains('final originalKey = persistedKey.value'));
  });
}
