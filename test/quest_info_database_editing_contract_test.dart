import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_quest_info_entity.dart';
import 'package:foxy/entity/quest_info_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect((const QuestInfoEntity(id: 7)).id, key);
    expect(const BriefQuestInfoEntity(id: 7).key, key);
  });

  test('QuestInfo 路由只携带标量 key 且列表统一传 brief.key', () {
    final page = File(
      'lib/page/quest_info/quest_info_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/quest_info/quest_info_list_page.dart',
    ).readAsStringSync();
    expect(page, contains('final int? questInfoKey'));
    expect(page, isNot(contains('final String? name')));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('infos[row].key'));
  });

  test('BriefQuestInfo 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_quest_info_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
