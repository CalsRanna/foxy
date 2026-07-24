// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'light_repository.dart';

mixin _LightRepositoryMixin on RepositoryMixin {
  Future<void> destroyLight(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_light'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<LightEntity?> getLight(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_light'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return LightEntity.fromJson(results.first.toMap());
  }

  Future<void> storeLight(LightEntity light) async {
    if (light.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(light);
    final json = _prepareWriteJson(light.toJson());
    try {
      await laconic.table('foxy.dbc_light').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateLight(int originalKey, LightEntity light) async {
    await _beforeUpdate(originalKey, light);
    final json = _prepareWriteJson(light.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_light'),
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

  Future<void> _beforeStore(LightEntity light) async {}

  Future<void> _beforeUpdate(int originalKey, LightEntity light) async {}

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

final class LightFilter {
  final String id;
  final String continentId;

  const LightFilter({this.id = '', this.continentId = ''});

  factory LightFilter.fromJson(Map<String, dynamic> json) {
    return LightFilter(
      id: json['id']?.toString() ?? '',
      continentId: json['continentId']?.toString() ?? '',
    );
  }

  LightFilter copyWith({String? id, String? continentId}) {
    return LightFilter(
      id: id ?? this.id,
      continentId: continentId ?? this.continentId,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'continentId': continentId};
  }
}
