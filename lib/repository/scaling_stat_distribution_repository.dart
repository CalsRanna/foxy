import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'scaling_stat_distribution_repository.g.dart';

@FoxyRepository(ScalingStatDistributionEntity)
@FoxyFilter.text('id')
class ScalingStatDistributionRepository
    with RepositoryMixin, _ScalingStatDistributionRepositoryMixin {
  static const _table = 'foxy.dbc_scaling_stat_distribution';

  Future<int> copyScalingStatDistribution(int key) async {
    final source = await getScalingStatDistribution(key);
    if (source == null) {
      throw StateError('原属性缩放分布不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeScalingStatDistribution(copied);
    return copied.id;
  }

  Future<int> countScalingStatDistributions({
    ScalingStatDistributionFilter? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ScalingStatDistributionEntity> createScalingStatDistribution() async {
    return ScalingStatDistributionEntity(id: await _getNextId());
  }

  Future<List<BriefScalingStatDistributionEntity>>
  getBriefScalingStatDistributions({
    int page = 1,
    ScalingStatDistributionFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = [
      'ID',
      'StatID0',
      'StatID1',
      'StatID2',
      'StatID3',
      'StatID4',
      'StatID5',
      'StatID6',
      'StatID7',
      'StatID8',
      'StatID9',
      'Bonus0',
      'Bonus1',
      'Bonus2',
      'Bonus3',
      'Bonus4',
      'Bonus5',
      'Bonus6',
      'Bonus7',
      'Bonus8',
      'Bonus9',
      'Maxlevel',
    ];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefScalingStatDistributionEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<ScalingStatDistributionEntity>>
  getScalingStatDistributions() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => ScalingStatDistributionEntity.fromJson(e.toMap()))
        .toList();
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ScalingStatDistributionFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 32767) {
      throw StateError('ScalingStatDistribution ID 已超出物品模板可引用范围');
    }
    return id;
  }
}
