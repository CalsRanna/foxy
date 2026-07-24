// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scaling_stat_value_repository.dart';

mixin _ScalingStatValueRepositoryMixin on RepositoryMixin {
  Future<void> destroyScalingStatValue(int key) async {
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

  Future<void> storeScalingStatValue(
    ScalingStatValueEntity scalingStatValue,
  ) async {
    if (scalingStatValue.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(scalingStatValue);
    final json = _prepareWriteJson(scalingStatValue.toJson());
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
    final json = _prepareWriteJson(scalingStatValue.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_scaling_stat_values'),
        originalKey,
      ).update(json);
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

  Future<void> _beforeStore(ScalingStatValueEntity scalingStatValue) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    ScalingStatValueEntity scalingStatValue,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    return {
      for (final entry in json.entries)
        if (const {'index', 'rank'}.contains(entry.key.toLowerCase()))
          '`${entry.key}`': entry.value
        else
          entry.key: entry.value,
    };
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

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
