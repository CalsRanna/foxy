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
  Future<int> copyScalingStatDistribution(int key) async {
    final source = await getScalingStatDistribution(key);
    if (source == null) {
      throw RecordNotFoundException(
        'foxy.dbc_scaling_stat_distribution record not found',
      );
    }
    final blank = await createScalingStatDistribution();
    final copied = source.copyWith(id: blank.id);
    await storeScalingStatDistribution(copied);
    return copied.id;
  }

  Future<int> countScalingStatDistributions({
    ScalingStatDistributionFilter? filter,
  }) async {
    return _applyFilter(
      laconic.table('foxy.dbc_scaling_stat_distribution'),
      filter,
    ).count();
  }

  Future<ScalingStatDistributionEntity> createScalingStatDistribution() async {
    return ScalingStatDistributionEntity(
      id: await nextMaxPlusOne('foxy.dbc_scaling_stat_distribution', '`ID`'),
    );
  }

  Future<void> destroyScalingStatDistribution(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_scaling_stat_distribution'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_scaling_stat_distribution record not found',
      );
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

  Future<List<BriefScalingStatDistributionEntity>>
  getBriefScalingStatDistributions({
    int page = 1,
    ScalingStatDistributionFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('foxy.dbc_scaling_stat_distribution').select([
      '`ID`',
      '`StatID0`',
      '`StatID1`',
      '`StatID2`',
      '`StatID3`',
      '`StatID4`',
      '`StatID5`',
      '`StatID6`',
      '`StatID7`',
      '`StatID8`',
      '`StatID9`',
      '`Bonus0`',
      '`Bonus1`',
      '`Bonus2`',
      '`Bonus3`',
      '`Bonus4`',
      '`Bonus5`',
      '`Bonus6`',
      '`Bonus7`',
      '`Bonus8`',
      '`Bonus9`',
      '`Maxlevel`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefScalingStatDistributionEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<ScalingStatDistributionEntity>>
  getScalingStatDistributions() async {
    var builder = laconic
        .table('foxy.dbc_scaling_stat_distribution')
        .orderBy('`ID`');
    final results = await builder.get();
    return results
        .map((e) => ScalingStatDistributionEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeScalingStatDistribution(
    ScalingStatDistributionEntity scalingStatDistribution,
  ) async {
    if (scalingStatDistribution.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(scalingStatDistribution);
    final json = prepareWriteJson(scalingStatDistribution.toJson());
    try {
      await laconic.table('foxy.dbc_scaling_stat_distribution').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = scalingStatDistribution.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_scaling_stat_distribution', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_scaling_stat_distribution').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_scaling_stat_distribution',
          );
        }
        rethrow;
      }
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
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_scaling_stat_distribution',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_scaling_stat_distribution record not found',
      );
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ScalingStatDistributionFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', int.tryParse(filter.id) ?? 0);
    }
    return builder;
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
