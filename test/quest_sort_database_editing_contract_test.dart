import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_quest_sort_entity.dart';
import 'package:foxy/entity/quest_sort_entity.dart';
import 'package:foxy/entity/quest_sort_key.dart';

void main() {
  test('QuestSortKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = QuestSortKey(id: 7);
    expect(key, const QuestSortKey(id: 7));
    expect(key.hashCode, const QuestSortKey(id: 7).hashCode);
    expect(QuestSortKey.fromEntity(const QuestSortEntity(id: 7)), key);
    expect(const BriefQuestSortEntity(id: 7).key, key);
  });

  test('QuestSort 路由只携带 typed key 且列表统一传 brief.key', () {
    final page = File(
      'lib/page/quest_sort/quest_sort_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/quest_sort/quest_sort_list_page.dart',
    ).readAsStringSync();
    expect(page, contains('final QuestSortKey? questSortKey'));
    expect(page, isNot(contains('final String? name')));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('sorts[row].key'));
  });

  test('BriefQuestSort 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_quest_sort_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
