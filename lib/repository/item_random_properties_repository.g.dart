// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_random_properties_repository.dart';

mixin _ItemRandomPropertiesRepositoryMixin on RepositoryMixin {
  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

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
