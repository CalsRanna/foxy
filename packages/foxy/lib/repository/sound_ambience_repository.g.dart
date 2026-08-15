// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_ambience_repository.dart';

final class SoundAmbienceFilter {
  final String id;

  const SoundAmbienceFilter({this.id = ''});

  factory SoundAmbienceFilter.fromJson(Map<String, dynamic> json) {
    return SoundAmbienceFilter(id: json['id']?.toString() ?? '');
  }

  SoundAmbienceFilter copyWith({String? id}) {
    return SoundAmbienceFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}

mixin _SoundAmbienceRepositoryMixin on RepositoryMixin {
  String get _table => 'foxy.dbc_sound_ambience';

  Future<void> destroySoundAmbience(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_sound_ambience record not found');
    }
  }

  Future<SoundAmbienceEntity?> getSoundAmbience(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SoundAmbienceEntity.fromJson(results.first.toMap());
  }

  Future<int> storeSoundAmbience(SoundAmbienceEntity soundAmbience) async {
    if (soundAmbience.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(soundAmbience);
    final json = prepareWriteJson(soundAmbience.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = soundAmbience.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_sound_ambience',
          );
        }
        rethrow;
      }
    }
    return soundAmbience.id;
  }

  Future<void> updateSoundAmbience(
    int originalKey,
    SoundAmbienceEntity soundAmbience,
  ) async {
    await _beforeUpdate(originalKey, soundAmbience);
    final json = prepareWriteJson(soundAmbience.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_sound_ambience');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_sound_ambience record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(SoundAmbienceEntity soundAmbience) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SoundAmbienceEntity soundAmbience,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
