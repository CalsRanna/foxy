// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_music_repository.dart';

final class ZoneMusicFilter {
  final String id;
  final String name;

  const ZoneMusicFilter({this.id = '', this.name = ''});

  factory ZoneMusicFilter.fromJson(Map<String, dynamic> json) {
    return ZoneMusicFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ZoneMusicFilter copyWith({String? id, String? name}) {
    return ZoneMusicFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _ZoneMusicRepositoryMixin on RepositoryMixin {
  Future<void> destroyZoneMusic(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_zone_music'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_zone_music record not found');
    }
  }

  Future<ZoneMusicEntity?> getZoneMusic(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_zone_music'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ZoneMusicEntity.fromJson(results.first.toMap());
  }

  Future<void> storeZoneMusic(ZoneMusicEntity zoneMusic) async {
    if (zoneMusic.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(zoneMusic);
    final json = prepareWriteJson(zoneMusic.toJson());
    try {
      await laconic.table('foxy.dbc_zone_music').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = zoneMusic.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_zone_music', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_zone_music').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_zone_music');
        }
        rethrow;
      }
    }
  }

  Future<void> updateZoneMusic(
    int originalKey,
    ZoneMusicEntity zoneMusic,
  ) async {
    await _beforeUpdate(originalKey, zoneMusic);
    final json = prepareWriteJson(zoneMusic.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_zone_music'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_zone_music');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_zone_music record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(ZoneMusicEntity zoneMusic) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    ZoneMusicEntity zoneMusic,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
