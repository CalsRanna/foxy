import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_emote_text_data_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect(const BriefEmoteTextDataEntity(id: 7).key, key);
  });

  test('EmoteTextData Repository 使用显式键并保留本表 locale API', () {
    final source = File(
      'lib/repository/emote_text_data_repository.dart',
    ).readAsStringSync();
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storeEmoteTextData('));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(data.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveEmoteTextDataLocales('));
    expect(source, isNot(contains('saveEmoteTextData(EmoteTextDataEntity')));
    expect(source, isNot(contains("remove('ID')")));
  });
}
