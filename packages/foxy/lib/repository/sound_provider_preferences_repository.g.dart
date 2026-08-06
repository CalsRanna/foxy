// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_provider_preferences_repository.dart';

final class SoundProviderPreferencesFilter {
  final String id;
  final String description;

  const SoundProviderPreferencesFilter({this.id = '', this.description = ''});

  factory SoundProviderPreferencesFilter.fromJson(Map<String, dynamic> json) {
    return SoundProviderPreferencesFilter(
      id: json['id']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }

  SoundProviderPreferencesFilter copyWith({String? id, String? description}) {
    return SoundProviderPreferencesFilter(
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'description': description};
  }
}

mixin _SoundProviderPreferencesRepositoryMixin on RepositoryMixin {
  Future<void> destroySoundProviderPreferences(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_sound_provider_preferences'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_sound_provider_preferences record not found',
      );
    }
  }

  Future<SoundProviderPreferencesEntity?> getSoundProviderPreferences(
    int key,
  ) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_sound_provider_preferences'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SoundProviderPreferencesEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSoundProviderPreferences(
    SoundProviderPreferencesEntity soundProviderPreferences,
  ) async {
    if (soundProviderPreferences.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(soundProviderPreferences);
    final json = prepareWriteJson(soundProviderPreferences.toJson());
    try {
      await laconic.table('foxy.dbc_sound_provider_preferences').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = soundProviderPreferences.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_sound_provider_preferences', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_sound_provider_preferences').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_sound_provider_preferences',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updateSoundProviderPreferences(
    int originalKey,
    SoundProviderPreferencesEntity soundProviderPreferences,
  ) async {
    await _beforeUpdate(originalKey, soundProviderPreferences);
    final json = prepareWriteJson(soundProviderPreferences.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_sound_provider_preferences'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_sound_provider_preferences',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_sound_provider_preferences record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    SoundProviderPreferencesEntity soundProviderPreferences,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SoundProviderPreferencesEntity soundProviderPreferences,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
