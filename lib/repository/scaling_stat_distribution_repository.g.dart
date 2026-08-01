// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scaling_stat_distribution_repository.dart';

final class ScalingStatDistributionFilter {
  final String id;

  const ScalingStatDistributionFilter({this.id = ''});

  factory ScalingStatDistributionFilter.fromJson(Map<String, dynamic> json) {
    return ScalingStatDistributionFilter(id: json['id']?.toString() ?? '');
  }

  ScalingStatDistributionFilter copyWith({String? id}) {
    return ScalingStatDistributionFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}

mixin _ScalingStatDistributionRepositoryMixin on RepositoryMixin {
  Future<void> destroyScalingStatDistribution(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_scaling_stat_distribution'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<ScalingStatDistributionEntity?> getScalingStatDistribution(
    int key,
  ) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_scaling_stat_distribution'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ScalingStatDistributionEntity.fromJson(results.first.toMap());
  }

  Future<void> storeScalingStatDistribution(
    ScalingStatDistributionEntity scalingStatDistribution,
  ) async {
    if (scalingStatDistribution.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(scalingStatDistribution);
    final json = prepareWriteJson(scalingStatDistribution.toJson());
    try {
      await laconic.table('foxy.dbc_scaling_stat_distribution').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateScalingStatDistribution(
    int originalKey,
    ScalingStatDistributionEntity scalingStatDistribution,
  ) async {
    await _beforeUpdate(originalKey, scalingStatDistribution);
    final json = prepareWriteJson(scalingStatDistribution.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_scaling_stat_distribution'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    ScalingStatDistributionEntity scalingStatDistribution,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    ScalingStatDistributionEntity scalingStatDistribution,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
