import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_char_title_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect(const BriefCharTitleEntity(id: 7).key, key);
  });

  test('CharTitle Repository 使用显式键并保留本表 locale API', () {
    final source = File(
      'lib/repository/char_title_repository.dart',
    ).readAsStringSync();
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storeCharTitle('));
    expect(source, contains('int originalKey'));
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
