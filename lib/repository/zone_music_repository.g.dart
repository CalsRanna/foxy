// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_music_repository.dart';

mixin _ZoneMusicRepositoryMixin on RepositoryMixin {
  Future<void> destroyZoneMusic(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_zone_music'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
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

  Future<void> updateZoneMusic(int originalKey, ZoneMusicEntity entity) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_zone_music'),
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
