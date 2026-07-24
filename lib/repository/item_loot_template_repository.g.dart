// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_loot_template_repository.dart';

final class ItemLootTemplateFilter {
  final String entry;
  final String name;

  const ItemLootTemplateFilter({this.entry = '', this.name = ''});

  factory ItemLootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return ItemLootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ItemLootTemplateFilter copyWith({String? entry, String? name}) {
    return ItemLootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
