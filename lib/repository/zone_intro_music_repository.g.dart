// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_intro_music_repository.dart';

final class ZoneIntroMusicFilter {
  final String id;
  final String name;

  const ZoneIntroMusicFilter({this.id = '', this.name = ''});

  factory ZoneIntroMusicFilter.fromJson(Map<String, dynamic> json) {
    return ZoneIntroMusicFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ZoneIntroMusicFilter copyWith({String? id, String? name}) {
    return ZoneIntroMusicFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _ZoneIntroMusicRepositoryMixin on RepositoryMixin {
  Future<void> destroyZoneIntroMusic(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_zone_intro_music_table'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_zone_intro_music_table record not found',
      );
    }
  }

  Future<ZoneIntroMusicEntity?> getZoneIntroMusic(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_zone_intro_music_table'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ZoneIntroMusicEntity.fromJson(results.first.toMap());
  }

  Future<void> storeZoneIntroMusic(ZoneIntroMusicEntity zoneIntroMusic) async {
    if (zoneIntroMusic.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(zoneIntroMusic);
    final json = prepareWriteJson(zoneIntroMusic.toJson());
    try {
      await laconic.table('foxy.dbc_zone_intro_music_table').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = zoneIntroMusic.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_zone_intro_music_table', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_zone_intro_music_table').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_zone_intro_music_table',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updateZoneIntroMusic(
    int originalKey,
    ZoneIntroMusicEntity zoneIntroMusic,
  ) async {
    await _beforeUpdate(originalKey, zoneIntroMusic);
    final json = prepareWriteJson(zoneIntroMusic.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_zone_intro_music_table'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_zone_intro_music_table',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_zone_intro_music_table record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(ZoneIntroMusicEntity zoneIntroMusic) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    ZoneIntroMusicEntity zoneIntroMusic,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
