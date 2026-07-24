// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_repository.dart';

final class VehicleFilter {
  final String id;

  const VehicleFilter({this.id = ''});

  factory VehicleFilter.fromJson(Map<String, dynamic> json) {
    return VehicleFilter(id: json['id']?.toString() ?? '');
  }

  VehicleFilter copyWith({String? id}) {
    return VehicleFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
