// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scaling_stat_distribution_repository.dart';

mixin _ScalingStatDistributionRepositoryMixin on RepositoryMixin {
  Future<void> destroyScalingStatDistribution(int key) async {
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

  Future<void> updateScalingStatDistribution(
    int originalKey,
    ScalingStatDistributionEntity distribution,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_scaling_stat_distribution'),
        originalKey,
      ).update(distribution.toJson());
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

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
