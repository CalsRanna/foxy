import 'package:foxy/entity/destructible_model_data_entity.dart';
import 'package:foxy/entity/destructible_model_data_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class DestructibleModelDataRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_destructible_model_data';

  Future<void> copyDestructibleModelData(int id) async {
    final source = await getDestructibleModelData(id);
    if (source == null) return;
    final json = source.toJson()..['ID'] = await nextMaxPlusOne(_table, 'ID');
    await laconic.table(_table).insert([json]);
  }

  Future<int> countDestructibleModelDatas({
    DestructibleModelDataFilterEntity? filter,
  }) => _applyFilter(laconic.table(_table), filter).count();

  Future<DestructibleModelDataEntity> createDestructibleModelData() async =>
      DestructibleModelDataEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<void> destroyDestructibleModelData(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefDestructibleModelDataEntity>>
  getBriefDestructibleModelDatas({
    int page = 1,
    DestructibleModelDataFilterEntity? filter,
  }) async {
    final rows = await _applyFilter(
      laconic.table(_table).select([
        'ID',
        'State1WMO',
        'State2WMO',
        'State3WMO',
      ]),
      filter,
    ).orderBy('ID').limit(kPageSize).offset((page - 1) * kPageSize).get();
    return rows
        .map((row) => BriefDestructibleModelDataEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<DestructibleModelDataEntity?> getDestructibleModelData(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    return rows.isEmpty
        ? null
        : DestructibleModelDataEntity.fromJson(rows.first.toMap());
  }

  Future<List<DestructibleModelDataEntity>> getDestructibleModelDatas() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => DestructibleModelDataEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> saveDestructibleModelData(
    DestructibleModelDataEntity entity,
  ) async {
    if (await getDestructibleModelData(entity.id) == null) {
      await storeDestructibleModelData(entity);
    } else {
      await updateDestructibleModelData(entity);
    }
  }

  Future<int> storeDestructibleModelData(
    DestructibleModelDataEntity entity,
  ) async {
    final json = entity.toJson();
    final id = entity.id > 0 ? entity.id : await nextMaxPlusOne(_table, 'ID');
    json['ID'] = id;
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateDestructibleModelData(
    DestructibleModelDataEntity entity,
  ) async {
    final json = entity.toJson()..remove('ID');
    await laconic.table(_table).where('ID', entity.id).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    DestructibleModelDataFilterEntity? filter,
  ) {
    if (filter != null && filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
