// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'totem_category_repository.dart';

final class TotemCategoryFilter {
  final String id;
  final String name;

  const TotemCategoryFilter({this.id = '', this.name = ''});

  factory TotemCategoryFilter.fromJson(Map<String, dynamic> json) {
    return TotemCategoryFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  TotemCategoryFilter copyWith({String? id, String? name}) {
    return TotemCategoryFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
