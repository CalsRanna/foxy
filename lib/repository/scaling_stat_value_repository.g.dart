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
