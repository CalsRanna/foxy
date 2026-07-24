import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/sound_ambience_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const first = 3;
    const same = 3;

    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect((const SoundAmbienceEntity(id: 3)).id, first);
    expect(const BriefSoundAmbienceEntity(id: 3).key, first);
  });

  test('SoundAmbience Repository 使用显式创建键与原始更新键', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/sound_ambience_repository.dart',
    );

    expect(source, contains('Future<int> copySoundAmbience('));
    expect(source, contains('Future<void> storeSoundAmbience('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeSoundAmbience')));
    expect(source, isNot(contains('saveSoundAmbience(')));
    expect(source, isNot(contains('insertAndGetId')));

    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
