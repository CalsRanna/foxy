// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_ambience_repository.dart';

mixin _SoundAmbienceRepositoryMixin on RepositoryMixin {
  Future<void> destroySoundAmbience(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_sound_ambience'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<SoundAmbienceEntity?> getSoundAmbience(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_sound_ambience'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SoundAmbienceEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSoundAmbience(SoundAmbienceEntity soundAmbience) async {
    if (soundAmbience.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(soundAmbience);
    final json = _prepareWriteJson(soundAmbience.toJson());
    try {
      await laconic.table('foxy.dbc_sound_ambience').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSoundAmbience(
    int originalKey,
    SoundAmbienceEntity soundAmbience,
  ) async {
    await _beforeUpdate(originalKey, soundAmbience);
    final json = _prepareWriteJson(soundAmbience.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_sound_ambience'),
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

  Future<void> _beforeStore(SoundAmbienceEntity soundAmbience) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SoundAmbienceEntity soundAmbience,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

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
