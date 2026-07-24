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
