import 'package:foxy/entity/scaling_stat_distribution_entity.dart';
import 'package:foxy/entity/scaling_stat_distribution_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ScalingStatDistributionRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_scaling_stat_distribution';

  Future<List<BriefScalingStatDistributionEntity>>
  getBriefScalingStatDistributions({
    int page = 1,
    ScalingStatDistributionFilterEntity? filter,
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

  Future<int> countScalingStatDistributions({
    ScalingStatDistributionFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ScalingStatDistributionEntity?> getScalingStatDistribution(
    int id,
  ) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return ScalingStatDistributionEntity.fromJson(results.first.toMap());
  }

  Future<ScalingStatDistributionEntity> createScalingStatDistribution() async {
    return ScalingStatDistributionEntity(id: await _getNextId());
  }

  Future<int> storeScalingStatDistribution(
    ScalingStatDistributionEntity distribution,
  ) async {
    final id = distribution.id > 0 ? distribution.id : await _getNextId();
    final stored = distribution.copyWith(id: id);
    await laconic.table(_table).insert([stored.toJson()]);
    return id;
  }

  Future<void> updateScalingStatDistribution(
    ScalingStatDistributionEntity distribution,
  ) async {
    var json = distribution.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', distribution.id).update(json);
  }

  Future<void> destroyScalingStatDistribution(int id) async {
    final references = await laconic
        .table('item_template')
        .where('ScalingStatDistribution', id)
        .count();
    if (references > 0) {
      throw StateError('该属性缩放分布仍被 $references 个物品模板引用，不能删除');
    }
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyScalingStatDistribution(int id) async {
    var source = await getScalingStatDistribution(id);
    if (source == null) return;
    final nextId = await _getNextId();
    final copied = source.copyWith(id: nextId);
    await laconic.table(_table).insert([copied.toJson()]);
  }

  Future<void> saveScalingStatDistribution(
    ScalingStatDistributionEntity distribution,
  ) async {
    if (distribution.id == 0) {
      await storeScalingStatDistribution(distribution);
      return;
    }
    var existing = await getScalingStatDistribution(distribution.id);
    if (existing != null) {
      await updateScalingStatDistribution(distribution);
    } else {
      await laconic.table(_table).insert([distribution.toJson()]);
    }
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 32767) {
      throw StateError('ScalingStatDistribution ID 已超出物品模板可引用范围');
    }
    return id;
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ScalingStatDistributionFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
