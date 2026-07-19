import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_sound_ambience_entity.dart';
import 'package:foxy/entity/sound_ambience_entity.dart';
import 'package:foxy/entity/sound_ambience_key.dart';

void main() {
  test('SoundAmbienceKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const first = SoundAmbienceKey(id: 3);
    const same = SoundAmbienceKey(id: 3);

    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(first, isNot(const SoundAmbienceKey(id: 4)));
    expect(
      SoundAmbienceKey.fromEntity(const SoundAmbienceEntity(id: 3)),
      first,
    );
    expect(const BriefSoundAmbienceEntity(id: 3).key, first);
  });

  test('SoundAmbience Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/sound_ambience_repository.dart',
    ).readAsStringSync();

    expect(source, contains('Future<SoundAmbienceKey> copySoundAmbience('));
    expect(source, contains('Future<void> storeSoundAmbience('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeSoundAmbience')));
    expect(source, isNot(contains('saveSoundAmbience(')));
    expect(source, isNot(contains('insertAndGetId')));

    expect(source, contains('SoundAmbienceKey originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
