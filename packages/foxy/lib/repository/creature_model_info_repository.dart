import 'package:foxy/entity/creature_model_info_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'creature_model_info_repository.g.dart';

@FoxyRepository(CreatureModelInfoEntity)
@FoxyFilter.text('id')
class CreatureModelInfoRepository
    with RepositoryMixin, _CreatureModelInfoRepositoryMixin {
  static const _table = 'creature_model_info';

  Future<int> copyCreatureModelInfo(int key) async {
    final source = await getCreatureModelInfo(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = CreatureModelInfoEntity.fromJson({
      ...source.toJson(),
      'DisplayID': await nextMaxPlusOne(_table, 'DisplayID'),
    });
    await storeCreatureModelInfo(copied);
    return copied.displayId;
  }

  Future<int> countCreatureModelInfos({CreatureModelInfoFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CreatureModelInfoEntity> createCreatureModelInfo() async {
    return CreatureModelInfoEntity(
      displayId: await nextMaxPlusOne(_table, 'DisplayID'),
    );
  }

  Future<List<BriefCreatureModelInfoEntity>> getBriefCreatureModelInfos({
    int page = 1,
    CreatureModelInfoFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'DisplayID',
      'BoundingRadius',
      'CombatReach',
      'Gender',
      'DisplayID_Other_Gender',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('DisplayID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefCreatureModelInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<CreatureModelInfoEntity>> getCreatureModelInfos() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => CreatureModelInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CreatureModelInfoFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('DisplayID', int.tryParse(filter.id) ?? 0);
    }
    return builder;
  }
}
