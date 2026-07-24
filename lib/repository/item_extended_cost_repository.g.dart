// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_extended_cost_repository.dart';

final class ItemExtendedCostFilter {
  final String id;

  const ItemExtendedCostFilter({this.id = ''});

  factory ItemExtendedCostFilter.fromJson(Map<String, dynamic> json) {
    return ItemExtendedCostFilter(id: json['id']?.toString() ?? '');
  }

  ItemExtendedCostFilter copyWith({String? id}) {
    return ItemExtendedCostFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
