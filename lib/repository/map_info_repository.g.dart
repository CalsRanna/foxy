// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_info_repository.dart';

final class MapInfoFilter {
  final String id;
  final String name;

  const MapInfoFilter({this.id = '', this.name = ''});

  factory MapInfoFilter.fromJson(Map<String, dynamic> json) {
    return MapInfoFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  MapInfoFilter copyWith({String? id, String? name}) {
    return MapInfoFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
