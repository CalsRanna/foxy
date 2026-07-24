// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_display_info_repository.dart';

final class ItemDisplayInfoFilter {
  final String id;
  final String name;

  const ItemDisplayInfoFilter({this.id = '', this.name = ''});

  factory ItemDisplayInfoFilter.fromJson(Map<String, dynamic> json) {
    return ItemDisplayInfoFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ItemDisplayInfoFilter copyWith({String? id, String? name}) {
    return ItemDisplayInfoFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
