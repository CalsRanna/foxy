import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/entity/brief_achievement_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect((const AchievementEntity(id: 7)).id, key);
    expect(const BriefAchievementEntity(id: 7).key, key);
  });

  test('Achievement 路由只携带标量 key 且列表传 brief.key', () {
    final page = File(
      'lib/page/achievement/achievement_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/achievement/achievement_list_page.dart',
    ).readAsStringSync();
    expect(page, contains('final int? achievementKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('items[row].key'));
  });
}
