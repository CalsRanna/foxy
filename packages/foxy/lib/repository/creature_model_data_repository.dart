import 'package:foxy/entity/creature_model_data_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'creature_model_data_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('modelName')
class CreatureModelDataRepository
    with RepositoryMixin, _CreatureModelDataRepositoryMixin {

  Future<int> copyCreatureModelData(int key) async {
    final source = await getCreatureModelData(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
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
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.modelName.isNotEmpty) {
      builder = builder.where(
        'ModelName',
        '%${escapeLike(filter.modelName)}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
