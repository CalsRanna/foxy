import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/creature_model_data_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'creature_model_data_repository.g.dart';

@FoxyRepository(CreatureModelDataEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('modelName')
class CreatureModelDataRepository
    with RepositoryMixin, _CreatureModelDataRepositoryMixin {
  static const _table = 'foxy.dbc_creature_model_data';

  Future<int> copyCreatureModelData(int key) async {
    final source = await getCreatureModelData(key);
    if (source == null) {
      throw StateError('原生物模型数据不存在，可能已被其他操作修改或删除');
    }
    final copied = CreatureModelDataEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeCreatureModelData(copied);
    return copied.id;
  }

  Future<int> countCreatureModelDatas({CreatureModelDataFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CreatureModelDataEntity> createCreatureModelData() async {
    return CreatureModelDataEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefCreatureModelDataEntity>> getBriefCreatureModelDatas({
    int page = 1,
    CreatureModelDataFilter? filter,
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

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CreatureModelDataFilter? filter,
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
