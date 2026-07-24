// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_intro_music_repository.dart';

mixin _ZoneIntroMusicRepositoryMixin on RepositoryMixin {
  Future<void> destroyZoneIntroMusic(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_zone_intro_music_table'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
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

  Future<void> updateZoneIntroMusic(
    int originalKey,
    ZoneIntroMusicEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_zone_intro_music_table'),
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
