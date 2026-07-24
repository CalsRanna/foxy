// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_loot_template_repository.dart';

mixin _ItemLootTemplateRepositoryMixin on RepositoryMixin {
  QueryBuilder _whereKey(QueryBuilder builder, ItemLootTemplateKey key) {
    var query = builder;
    query = query.where('Entry', key.entry);
    query = query.where('Item', key.item);
    return query;
  }
}

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
