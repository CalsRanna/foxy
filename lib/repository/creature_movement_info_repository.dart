import 'package:foxy/entity/creature_movement_info_entity.dart';
import 'package:foxy/entity/creature_movement_info_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureMovementInfoRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_creature_movement_info';

  Future<List<CreatureMovementInfoEntity>> getBriefCreatureMovementInfos({
    int page = 1,
    CreatureMovementInfoFilterEntity? filter,
  }) async {
    final offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((row) => CreatureMovementInfoEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<CreatureMovementInfoEntity>> getCreatureMovementInfos() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => CreatureMovementInfoEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<int> countCreatureMovementInfos({
    CreatureMovementInfoFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CreatureMovementInfoEntity?> getCreatureMovementInfo(int id) async {
    final results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureMovementInfoEntity.fromJson(results.first.toMap());
  }

  Future<CreatureMovementInfoEntity> createCreatureMovementInfo() async {
    return CreatureMovementInfoEntity(id: await _getNextId());
  }

  Future<int> storeCreatureMovementInfo(
    CreatureMovementInfoEntity movementInfo,
  ) async {
    final json = movementInfo.toJson();
    final nextId = movementInfo.id > 0 ? movementInfo.id : await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateCreatureMovementInfo(
    CreatureMovementInfoEntity movementInfo,
  ) async {
    final json = movementInfo.toJson()..remove('ID');
    await laconic.table(_table).where('ID', movementInfo.id).update(json);
  }

  Future<void> destroyCreatureMovementInfo(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyCreatureMovementInfo(int id) async {
    final source = await getCreatureMovementInfo(id);
    if (source == null) return;
    final json = source.toJson();
    json['ID'] = await _getNextId();
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveCreatureMovementInfo(
    CreatureMovementInfoEntity movementInfo,
  ) async {
    final existing = await getCreatureMovementInfo(movementInfo.id);
    if (existing == null) {
      await storeCreatureMovementInfo(movementInfo);
      return;
    }
    await updateCreatureMovementInfo(movementInfo);
  }

  Future<int> _getNextId() async {
    return nextMaxPlusOne(_table, 'ID');
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CreatureMovementInfoFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
