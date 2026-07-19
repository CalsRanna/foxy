import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_char_title_entity.dart';
import 'package:foxy/entity/char_title_key.dart';

void main() {
  test('CharTitleKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = CharTitleKey(id: 7);
    expect(key, const CharTitleKey(id: 7));
    expect(key.hashCode, const CharTitleKey(id: 7).hashCode);
    expect(const BriefCharTitleEntity(id: 7).key, key);
  });

  test('CharTitle Repository 使用显式键并保留本表 locale API', () {
    final source = File(
      'lib/repository/char_title_repository.dart',
    ).readAsStringSync();
    expect(source, contains('CharTitleKey key'));
    expect(source, contains('Future<void> storeCharTitle('));
    expect(source, contains('CharTitleKey originalKey'));
    expect(source, contains('.update(title.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveCharTitleLocales('));
    expect(source, isNot(contains('saveCharTitle(CharTitleEntity')));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefCharTitle 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_char_title_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
