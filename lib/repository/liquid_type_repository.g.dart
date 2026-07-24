// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liquid_type_repository.dart';

final class LiquidTypeFilter {
  final String id;
  final String name;

  const LiquidTypeFilter({this.id = '', this.name = ''});

  factory LiquidTypeFilter.fromJson(Map<String, dynamic> json) {
    return LiquidTypeFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  LiquidTypeFilter copyWith({String? id, String? name}) {
    return LiquidTypeFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
