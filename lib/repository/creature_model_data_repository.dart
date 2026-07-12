import 'package:foxy/entity/creature_model_data_entity.dart';
import 'package:foxy/entity/creature_model_data_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureModelDataRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_creature_model_data';

  Future<List<BriefCreatureModelDataEntity>> getBriefCreatureModelDatas({
    int page = 1,
    CreatureModelDataFilterEntity? filter,
  }) async {
    final offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
      'ID',
      'ModelName',
      'SizeClass',
      'ModelScale',
    ]);
    builder = _applyFilter(builder, filter);
    final results = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset(offset)
        .get();
    return results
        .map((e) => BriefCreatureModelDataEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<CreatureModelDataEntity>> getCreatureModelDatas() async {
    final results = await laconic.table(_table).orderBy('ID').get();
    return results
        .map((e) => CreatureModelDataEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countCreatureModelDatas({
    CreatureModelDataFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CreatureModelDataEntity?> getCreatureModelData(int id) async {
    final results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureModelDataEntity.fromJson(results.first.toMap());
  }

  Future<CreatureModelDataEntity> createCreatureModelData() async {
    return CreatureModelDataEntity(id: await _getNextId());
  }

  Future<int> storeCreatureModelData(CreatureModelDataEntity entity) async {
    final json = entity.toJson();
    final nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateCreatureModelData(CreatureModelDataEntity entity) async {
    final json = entity.toJson()..remove('ID');
    await laconic.table(_table).where('ID', entity.id).update(json);
  }

  Future<void> destroyCreatureModelData(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyCreatureModelData(int id) async {
    final source = await getCreatureModelData(id);
    if (source == null) return;
    final json = source.toJson();
    json['ID'] = await _getNextId();
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveCreatureModelData(CreatureModelDataEntity entity) async {
    if (entity.id == 0) {
      await storeCreatureModelData(entity);
      return;
    }
    final existing = await getCreatureModelData(entity.id);
    if (existing != null) {
      await updateCreatureModelData(entity);
    } else {
      await laconic.table(_table).insert([entity.toJson()]);
    }
  }

  Future<int> _getNextId() async {
    return nextMaxPlusOne(_table, 'ID');
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CreatureModelDataFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.modelName.isNotEmpty) {
      builder = builder.where(
        'ModelName',
        '%${filter.modelName}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
