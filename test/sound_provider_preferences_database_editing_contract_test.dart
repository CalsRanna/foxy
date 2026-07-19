import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_sound_provider_preferences_entity.dart';
import 'package:foxy/entity/sound_provider_preferences_entity.dart';
import 'package:foxy/entity/sound_provider_preferences_key.dart';

void main() {
  test('SoundProviderPreferencesKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const first = SoundProviderPreferencesKey(id: 6);
    const same = SoundProviderPreferencesKey(id: 6);

    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(first, isNot(const SoundProviderPreferencesKey(id: 7)));
    expect(
      SoundProviderPreferencesKey.fromEntity(
        const SoundProviderPreferencesEntity(id: 6),
      ),
      first,
    );
    expect(const BriefSoundProviderPreferencesEntity(id: 6).key, first);
  });

  test('SoundProviderPreferences Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/sound_provider_preferences_repository.dart',
    ).readAsStringSync();

    expect(
      source,
      contains(
        'Future<SoundProviderPreferencesKey> copySoundProviderPreference(',
      ),
    );
    expect(source, contains('Future<void> storeSoundProviderPreference('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeSoundProviderPreference')));
    expect(source, isNot(contains('saveSoundProviderPreference(')));
    expect(source, isNot(contains('insertAndGetId')));

    expect(source, contains('SoundProviderPreferencesKey originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
