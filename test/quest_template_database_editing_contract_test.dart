import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_quest_template_entity.dart';
import 'package:foxy/entity/quest_template_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect((const QuestTemplateEntity(id: 7)).id, key);
    expect(const BriefQuestTemplateEntity(id: 7).key, key);
  });

  test('Repository 使用原 key、完整 candidate 和单表写入边界', () {
    final source = File(
      'lib/repository/quest_template_repository.dart',
    ).readAsStringSync();
    expect(source, contains('int originalKey'));
    expect(source, contains(').update(template.toJson())'));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveQuestTemplate(')));
    expect(source, isNot(contains("json.remove('ID')")));
  });

  test('详情路由只携带标量 key 且列表传 brief.key', () {
    final page = File(
      'lib/page/quest/quest_template_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/quest/quest_template_list_page.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/quest/quest_template_view.dart',
    ).readAsStringSync();
    expect(page, contains('final int? questTemplateKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('item.key'));
    expect(view, contains('viewModel.persistedKey.value'));
    expect(view, isNot(contains('readOnly: true')));
  });

  test('BriefQuestTemplate 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_quest_template_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
