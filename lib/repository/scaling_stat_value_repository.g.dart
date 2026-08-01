// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scaling_stat_value_repository.dart';

final class ScalingStatValueFilter {
  final String id;
  final String charlevel;

  const ScalingStatValueFilter({this.id = '', this.charlevel = ''});

  factory ScalingStatValueFilter.fromJson(Map<String, dynamic> json) {
    return ScalingStatValueFilter(
      id: json['id']?.toString() ?? '',
      charlevel: json['charlevel']?.toString() ?? '',
    );
  }

  ScalingStatValueFilter copyWith({String? id, String? charlevel}) {
    return ScalingStatValueFilter(
      id: id ?? this.id,
      charlevel: charlevel ?? this.charlevel,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'charlevel': charlevel};
  }
}

mixin _ScalingStatValueRepositoryMixin on RepositoryMixin {
  Future<int> copyScalingStatValue(int key) async {
    final source = await getScalingStatValue(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createScalingStatValue();
    final copied = source.copyWith(id: blank.id);
    await storeScalingStatValue(copied);
    return copied.id;
  }

  Future<int> countScalingStatValues({ScalingStatValueFilter? filter}) async {
    return _applyFilter(
      laconic.table('foxy.dbc_scaling_stat_values'),
      filter,
    ).count();
  }

  Future<ScalingStatValueEntity> createScalingStatValue() async {
    return ScalingStatValueEntity(
      id: await nextMaxPlusOne('foxy.dbc_scaling_stat_values', '`ID`'),
    );
  }

  Future<void> destroyScalingStatValue(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_scaling_stat_values'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<ScalingStatValueEntity?> getScalingStatValue(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_scaling_stat_values'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ScalingStatValueEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefScalingStatValueEntity>> getBriefScalingStatValues({
    int page = 1,
    ScalingStatValueFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('foxy.dbc_scaling_stat_values').select([
      '`ID`',
      '`Charlevel`',
      '`ShoulderBudget`',
      '`TrinketBudget`',
      '`WeaponBudget1H`',
      '`RangedBudget`',
      '`PrimaryBudget`',
      '`TertiaryBudget`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefScalingStatValueEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<ScalingStatValueEntity>> getScalingStatValues() async {
    var builder = laconic.table('foxy.dbc_scaling_stat_values').orderBy('`ID`');
    final results = await builder.get();
    return results
        .map((e) => ScalingStatValueEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeScalingStatValue(
    ScalingStatValueEntity scalingStatValue,
  ) async {
    if (scalingStatValue.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(scalingStatValue);
    final json = prepareWriteJson(scalingStatValue.toJson());
    try {
      await laconic.table('foxy.dbc_scaling_stat_values').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateScalingStatValue(
    int originalKey,
    ScalingStatValueEntity scalingStatValue,
  ) async {
    await _beforeUpdate(originalKey, scalingStatValue);
    final json = prepareWriteJson(scalingStatValue.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_scaling_stat_values'),
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

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ScalingStatValueFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', filter.id);
    }
    if (filter.charlevel.isNotEmpty) {
      builder = builder.where('`Charlevel`', filter.charlevel);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(ScalingStatValueEntity scalingStatValue) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    ScalingStatValueEntity scalingStatValue,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
