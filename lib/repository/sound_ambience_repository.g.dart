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

  Future<void> updateSoundAmbience(
    int originalKey,
    SoundAmbienceEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_sound_ambience'),
        originalKey,
      ).update(entity.toJson());
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
