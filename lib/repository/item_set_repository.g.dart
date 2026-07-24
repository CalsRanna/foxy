// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_set_repository.dart';

final class ItemSetFilter {
  final String id;
  final String name;

  const ItemSetFilter({this.id = '', this.name = ''});

  factory ItemSetFilter.fromJson(Map<String, dynamic> json) {
    return ItemSetFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ItemSetFilter copyWith({String? id, String? name}) {
    return ItemSetFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
