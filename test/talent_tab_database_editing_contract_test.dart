import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/talent_tab_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect(const BriefTalentTabEntity(id: 7).key, key);
  });

  test('TalentTab Repository 使用显式键、完整 candidate 和单表边界', () {
    final source = File(
      'lib/repository/talent_tab_repository.dart',
    ).readAsStringSync();
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storeTalentTab('));
    expect(source, contains('int originalKey'));
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
}
