// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_random_properties_repository.dart';

final class ItemRandomPropertiesFilter {
  final String id;
  final String name;

  const ItemRandomPropertiesFilter({this.id = '', this.name = ''});

  factory ItemRandomPropertiesFilter.fromJson(Map<String, dynamic> json) {
    return ItemRandomPropertiesFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ItemRandomPropertiesFilter copyWith({String? id, String? name}) {
    return ItemRandomPropertiesFilter(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
