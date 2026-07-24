import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_creature_template_entity.dart';
import 'package:foxy/entity/creature_template_entity.dart';

void main() {
  test('Brief key 返回物理 entry 标量', () {
    const key = 7;
    expect((const CreatureTemplateEntity(entry: 7)).entry, key);
    expect(const BriefCreatureTemplateEntity(entry: 7).key, key);
  });

  test('Repository 使用原 key、完整 candidate 和单表写入边界', () {
    final source = File(
      'lib/repository/creature_template_repository.dart',
    ).readAsStringSync();
    expect(source, contains('int originalKey'));
    expect(source, contains(').update(json)'));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveCreatureTemplate(')));
    expect(source, isNot(contains("json.remove('entry')")));
  });

  test('详情路由只携带标量 key 且列表传 brief.key', () {
    final page = File(
      'lib/page/creature_template/creature_template_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/creature_template/creature_template_list_page.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/creature_template/creature_template_view.dart',
    ).readAsStringSync();
    expect(page, contains('final int? creatureTemplateKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('templates[row].key'));
    expect(view, contains('viewModel.persistedKey.value'));
    expect(view, isNot(contains('readOnly: true')));
  });
}
