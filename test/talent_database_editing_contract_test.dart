import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_talent_entity.dart';
import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy/entity/talent_key.dart';

void main() {
  test('TalentKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = TalentKey(id: 7);
    expect(key, const TalentKey(id: 7));
    expect(key.hashCode, const TalentKey(id: 7).hashCode);
    expect(TalentKey.fromEntity(const TalentEntity(id: 7)), key);
    expect(const BriefTalentEntity(id: 7).key, key);
  });

  test('Talent 路由只携带 typed key 且列表传 brief.key', () {
    final page = File(
      'lib/page/talent/talent_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/talent/talent_list_page.dart',
    ).readAsStringSync();
    expect(page, contains('final TalentKey? talentKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('items[row].key'));
  });

  test('BriefTalent 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_talent_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
