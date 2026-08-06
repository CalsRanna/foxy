// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_limit_category_repository.dart';

final class ItemLimitCategoryFilter {
  final String id;
  final String name;

  const ItemLimitCategoryFilter({this.id = '', this.name = ''});

  factory ItemLimitCategoryFilter.fromJson(Map<String, dynamic> json) {
    return ItemLimitCategoryFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ItemLimitCategoryFilter copyWith({String? id, String? name}) {
    return ItemLimitCategoryFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
