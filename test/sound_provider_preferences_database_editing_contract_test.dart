import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/sound_provider_preferences_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const first = 6;
    const same = 6;

    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect((const SoundProviderPreferencesEntity(id: 6)).id, first);
    expect(const BriefSoundProviderPreferencesEntity(id: 6).key, first);
  });

  test('SoundProviderPreferences Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/sound_provider_preferences_repository.dart',
    ).readAsStringSync();

    expect(source, contains('Future<int> copySoundProviderPreference('));
    expect(source, contains('Future<void> storeSoundProviderPreference('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeSoundProviderPreference')));
    expect(source, isNot(contains('saveSoundProviderPreference(')));
    expect(source, isNot(contains('insertAndGetId')));

    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
