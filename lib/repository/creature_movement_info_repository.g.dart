// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_movement_info_repository.dart';

mixin _CreatureMovementInfoRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureMovementInfo(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_creature_movement_info'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureMovementInfoEntity?> getCreatureMovementInfo(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_creature_movement_info'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureMovementInfoEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureMovementInfo(
    CreatureMovementInfoEntity creatureMovementInfo,
  ) async {
    if (creatureMovementInfo.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(creatureMovementInfo);
    final json = _prepareWriteJson(creatureMovementInfo.toJson());
    try {
      await laconic.table('foxy.dbc_creature_movement_info').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureMovementInfo(
    int originalKey,
    CreatureMovementInfoEntity creatureMovementInfo,
  ) async {
    await _beforeUpdate(originalKey, creatureMovementInfo);
    final json = _prepareWriteJson(creatureMovementInfo.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_creature_movement_info'),
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
    CreatureMovementInfoEntity creatureMovementInfo,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CreatureMovementInfoEntity creatureMovementInfo,
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

final class CreatureMovementInfoFilter {
  final String id;

  const CreatureMovementInfoFilter({this.id = ''});

  factory CreatureMovementInfoFilter.fromJson(Map<String, dynamic> json) {
    return CreatureMovementInfoFilter(id: json['id']?.toString() ?? '');
  }

  CreatureMovementInfoFilter copyWith({String? id}) {
    return CreatureMovementInfoFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
