// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_movement_info_repository.dart';

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

mixin _CreatureMovementInfoRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureMovementInfo(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_creature_movement_info'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_creature_movement_info record not found',
      );
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
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(creatureMovementInfo);
    final json = prepareWriteJson(creatureMovementInfo.toJson());
    try {
      await laconic.table('foxy.dbc_creature_movement_info').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_creature_movement_info',
        );
      }
      rethrow;
    }
  }

  Future<void> updateCreatureMovementInfo(
    int originalKey,
    CreatureMovementInfoEntity creatureMovementInfo,
  ) async {
    await _beforeUpdate(originalKey, creatureMovementInfo);
    final json = prepareWriteJson(creatureMovementInfo.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_creature_movement_info'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_creature_movement_info',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_creature_movement_info record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    CreatureMovementInfoEntity creatureMovementInfo,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CreatureMovementInfoEntity creatureMovementInfo,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
