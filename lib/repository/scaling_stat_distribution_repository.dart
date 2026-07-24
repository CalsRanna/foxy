import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'scaling_stat_distribution_repository.g.dart';

@FoxyRepositoryFilter(
  name: 'ScalingStatDistributionFilter',
  fields: [
    FoxyRepositoryFilterField(
      name: 'id',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
  ],
)
class ScalingStatDistributionRepository with RepositoryMixin {
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

  Future<void> destroyScalingStatDistribution(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原属性缩放分布不存在，可能已被其他操作修改或删除');
    }
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

  Future<ScalingStatDistributionEntity?> getScalingStatDistribution(
    int key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return ScalingStatDistributionEntity.fromJson(results.first.toMap());
  }

  Future<List<ScalingStatDistributionEntity>>
  getScalingStatDistributions() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => ScalingStatDistributionEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeScalingStatDistribution(
    ScalingStatDistributionEntity distribution,
  ) async {
    if (distribution.id <= 0) {
      throw StateError('属性缩放分布 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([distribution.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('属性缩放分布 ${distribution.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateScalingStatDistribution(
    int originalKey,
    ScalingStatDistributionEntity distribution,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(distribution.toJson());
      if (matchedRows == 0) {
        throw StateError('原属性缩放分布不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的属性缩放分布 ID 已存在，无法保存');
      }
      rethrow;
    }
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

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
