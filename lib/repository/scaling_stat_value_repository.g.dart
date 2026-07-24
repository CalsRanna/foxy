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
