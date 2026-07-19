import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/entity/achievement_key.dart';
import 'package:foxy/entity/brief_achievement_entity.dart';

void main() {
  test('AchievementKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = AchievementKey(id: 7);
    expect(key, const AchievementKey(id: 7));
    expect(key.hashCode, const AchievementKey(id: 7).hashCode);
    expect(AchievementKey.fromEntity(const AchievementEntity(id: 7)), key);
    expect(const BriefAchievementEntity(id: 7).key, key);
  });

  test('Achievement 路由只携带 typed key 且列表传 brief.key', () {
    final page = File(
      'lib/page/achievement/achievement_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/achievement/achievement_list_page.dart',
    ).readAsStringSync();
    expect(page, contains('final AchievementKey? achievementKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('items[row].key'));
  });

  test('BriefAchievement 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_achievement_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
