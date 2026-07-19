import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_emote_text_entity.dart';
import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/entity/emote_text_key.dart';

void main() {
  test('EmoteTextKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = EmoteTextKey(id: 7);
    expect(key, const EmoteTextKey(id: 7));
    expect(key.hashCode, const EmoteTextKey(id: 7).hashCode);
    expect(EmoteTextKey.fromEntity(const EmoteTextEntity(id: 7)), key);
    expect(const BriefEmoteTextEntity(id: 7).key, key);
  });

  test('EmoteText 使用完整 candidate、单表写入和 persisted identity', () {
    final repository = File(
      'lib/repository/emote_text_repository.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/emote_text/emote_text_detail_view_model.dart',
    ).readAsStringSync();
    final page = File(
      'lib/page/emote_text/emote_text_detail_page.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/emote_text/emote_text_view.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/emote_text/emote_text_list_page.dart',
    ).readAsStringSync();

    expect(repository, contains('EmoteTextKey originalKey'));
    expect(repository, contains('.update(emoteText.toJson())'));
    expect(repository, contains('matchedRows == 0'));
    expect(repository, contains('deletedRows == 0'));
    expect(repository, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(repository, isNot(contains('saveEmoteText(')));
    expect(repository, isNot(contains("remove('ID')")));
    expect(viewModel, contains('signal<EmoteTextKey?>(null)'));
    expect(viewModel, contains('final originalKey = persistedKey.value'));
    expect(viewModel, contains('updateEmoteText(originalKey, candidate)'));
    expect(viewModel, contains('persistedKey.value = EmoteTextKey'));
    expect(page, contains('final EmoteTextKey? emoteTextKey'));
    expect(page, isNot(contains('final String? name')));
    expect(view, isNot(contains('readOnly: true')));
    expect(list, contains('emotes[row].key'));
  });

  test('BriefEmoteText 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_emote_text_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
