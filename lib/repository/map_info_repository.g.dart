// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_info_repository.dart';

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

mixin _MapInfoRepositoryMixin on RepositoryMixin, DbcLocaleRepositoryMixin {
  Future<void> destroyMapInfo(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_map'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_map record not found');
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

  Future<List<DbcLocaleFieldValue>> getMapInfoLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveMapInfoLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeMapInfo(MapInfoEntity mapInfo) async {
    if (mapInfo.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(mapInfo);
    final json = prepareWriteJson(mapInfo.toJson());
    try {
      await laconic.table('foxy.dbc_map').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_map');
      }
      rethrow;
    }
  }

  Future<void> updateMapInfo(int originalKey, MapInfoEntity mapInfo) async {
    await _beforeUpdate(originalKey, mapInfo);
    final json = prepareWriteJson(mapInfo.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_map'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_map');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_map record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(MapInfoEntity mapInfo) async {}

  Future<void> _beforeUpdate(int originalKey, MapInfoEntity mapInfo) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
