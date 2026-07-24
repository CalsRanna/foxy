// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_table_repository.dart';

final class AreaTableFilter {
  final String id;
  final String name;

  const AreaTableFilter({this.id = '', this.name = ''});

  factory AreaTableFilter.fromJson(Map<String, dynamic> json) {
    return AreaTableFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  AreaTableFilter copyWith({String? id, String? name}) {
    return AreaTableFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
