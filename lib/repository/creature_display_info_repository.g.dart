// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_display_info_repository.dart';

mixin _CreatureDisplayInfoRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureDisplayInfo(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_creature_display_info'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureDisplayInfoEntity?> getCreatureDisplayInfo(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_creature_display_info'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureDisplayInfoEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureDisplayInfo(
    CreatureDisplayInfoEntity creatureDisplayInfo,
  ) async {
    if (creatureDisplayInfo.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(creatureDisplayInfo);
    final json = _prepareWriteJson(creatureDisplayInfo.toJson());
    try {
      await laconic.table('foxy.dbc_creature_display_info').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureDisplayInfo(
    int originalKey,
    CreatureDisplayInfoEntity creatureDisplayInfo,
  ) async {
    await _beforeUpdate(originalKey, creatureDisplayInfo);
    final json = _prepareWriteJson(creatureDisplayInfo.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_creature_display_info'),
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
    CreatureDisplayInfoEntity creatureDisplayInfo,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CreatureDisplayInfoEntity creatureDisplayInfo,
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

final class CreatureDisplayInfoFilter {
  final String id;
  final String modelName;

  const CreatureDisplayInfoFilter({this.id = '', this.modelName = ''});

  factory CreatureDisplayInfoFilter.fromJson(Map<String, dynamic> json) {
    return CreatureDisplayInfoFilter(
      id: json['id']?.toString() ?? '',
      modelName: json['modelName']?.toString() ?? '',
    );
  }

  CreatureDisplayInfoFilter copyWith({String? id, String? modelName}) {
    return CreatureDisplayInfoFilter(
      id: id ?? this.id,
      modelName: modelName ?? this.modelName,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'modelName': modelName};
  }
}
