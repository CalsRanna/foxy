// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_random_suffix_repository.dart';

final class ItemRandomSuffixFilter {
  final String id;
  final String name;

  const ItemRandomSuffixFilter({this.id = '', this.name = ''});

  factory ItemRandomSuffixFilter.fromJson(Map<String, dynamic> json) {
    return ItemRandomSuffixFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ItemRandomSuffixFilter copyWith({String? id, String? name}) {
    return ItemRandomSuffixFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
