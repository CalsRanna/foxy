// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waypoint_data_repository.dart';

final class WaypointDataFilter {
  final String id;

  const WaypointDataFilter({this.id = ''});

  factory WaypointDataFilter.fromJson(Map<String, dynamic> json) {
    return WaypointDataFilter(id: json['id']?.toString() ?? '');
  }

  WaypointDataFilter copyWith({String? id}) {
    return WaypointDataFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
