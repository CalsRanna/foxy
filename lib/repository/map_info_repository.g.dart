// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_info_repository.dart';

mixin _MapInfoRepositoryMixin on RepositoryMixin {
  Future<void> destroyMapInfo(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_map'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<MapInfoEntity?> getMapInfo(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_map'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return MapInfoEntity.fromJson(results.first.toMap());
  }

  Future<void> storeMapInfo(MapInfoEntity mapInfo) async {
    if (mapInfo.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(mapInfo);
    final json = _prepareWriteJson(mapInfo.toJson());
    try {
      await laconic.table('foxy.dbc_map').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateMapInfo(int originalKey, MapInfoEntity mapInfo) async {
    await _beforeUpdate(originalKey, mapInfo);
    final json = _prepareWriteJson(mapInfo.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_map'),
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

  Future<void> _beforeStore(MapInfoEntity mapInfo) async {}

  Future<void> _beforeUpdate(int originalKey, MapInfoEntity mapInfo) async {}

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

final class MapInfoFilter {
  final String id;
  final String name;

  const MapInfoFilter({this.id = '', this.name = ''});

  factory MapInfoFilter.fromJson(Map<String, dynamic> json) {
    return MapInfoFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  MapInfoFilter copyWith({String? id, String? name}) {
    return MapInfoFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
