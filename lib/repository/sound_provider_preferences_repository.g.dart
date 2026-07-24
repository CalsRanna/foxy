// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_provider_preferences_repository.dart';

mixin _SoundProviderPreferencesRepositoryMixin on RepositoryMixin {
  Future<void> destroySoundProviderPreferences(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_sound_provider_preferences'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
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
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(soundProviderPreferences);
    final json = _prepareWriteJson(soundProviderPreferences.toJson());
    try {
      await laconic.table('foxy.dbc_sound_provider_preferences').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSoundProviderPreferences(
    int originalKey,
    SoundProviderPreferencesEntity soundProviderPreferences,
  ) async {
    await _beforeUpdate(originalKey, soundProviderPreferences);
    final json = _prepareWriteJson(soundProviderPreferences.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_sound_provider_preferences'),
        originalKey,
      ).update(json);
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
  }

  Future<void> _beforeStore(
    SoundProviderPreferencesEntity soundProviderPreferences,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SoundProviderPreferencesEntity soundProviderPreferences,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    return {
      for (final entry in json.entries)
        if (const {'index', 'rank'}.contains(entry.key.toLowerCase()))
          '`${entry.key}`': entry.value
        else
          entry.key: entry.value,
    };
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

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
