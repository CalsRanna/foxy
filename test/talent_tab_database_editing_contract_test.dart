import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_talent_tab_entity.dart';
import 'package:foxy/entity/talent_tab_key.dart';

void main() {
  test('TalentTabKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = TalentTabKey(id: 7);
    expect(key, const TalentTabKey(id: 7));
    expect(key.hashCode, const TalentTabKey(id: 7).hashCode);
    expect(const BriefTalentTabEntity(id: 7).key, key);
  });

  test('TalentTab Repository 使用显式键、完整 candidate 和单表边界', () {
    final source = File(
      'lib/repository/talent_tab_repository.dart',
    ).readAsStringSync();
    expect(source, contains('TalentTabKey key'));
    expect(source, contains('Future<void> storeTalentTab('));
    expect(source, contains('TalentTabKey originalKey'));
    expect(source, contains('.update(talentTab.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveTalentTabLocales('));
    expect(source, isNot(contains('saveTalentTab(TalentTabEntity')));
    expect(source, isNot(contains("table('foxy.dbc_talent')")));
    expect(source, isNot(contains("table('foxy.dbc_spell_icon')")));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefTalentTab 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_talent_tab_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
