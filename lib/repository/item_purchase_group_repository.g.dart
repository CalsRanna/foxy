// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_purchase_group_repository.dart';

final class ItemPurchaseGroupFilter {
  final String id;
  final String name;

  const ItemPurchaseGroupFilter({this.id = '', this.name = ''});

  factory ItemPurchaseGroupFilter.fromJson(Map<String, dynamic> json) {
    return ItemPurchaseGroupFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ItemPurchaseGroupFilter copyWith({String? id, String? name}) {
    return ItemPurchaseGroupFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
