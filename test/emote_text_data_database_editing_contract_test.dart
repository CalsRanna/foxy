import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_emote_text_data_entity.dart';
import 'package:foxy/entity/emote_text_data_key.dart';

void main() {
  test('EmoteTextDataKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = EmoteTextDataKey(id: 7);
    expect(key, const EmoteTextDataKey(id: 7));
    expect(key.hashCode, const EmoteTextDataKey(id: 7).hashCode);
    expect(const BriefEmoteTextDataEntity(id: 7).key, key);
  });

  test('EmoteTextData Repository 使用显式键并保留本表 locale API', () {
    final source = File(
      'lib/repository/emote_text_data_repository.dart',
    ).readAsStringSync();
    expect(source, contains('EmoteTextDataKey key'));
    expect(source, contains('Future<void> storeEmoteTextData('));
    expect(source, contains('EmoteTextDataKey originalKey'));
    expect(source, contains('.update(data.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveEmoteTextDataLocales('));
    expect(source, isNot(contains('saveEmoteTextData(EmoteTextDataEntity')));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefEmoteTextData 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_emote_text_data_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
