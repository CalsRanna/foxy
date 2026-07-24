// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milling_loot_template_repository.dart';

mixin _MillingLootTemplateRepositoryMixin on RepositoryMixin {
  QueryBuilder _whereKey(QueryBuilder builder, MillingLootTemplateKey key) {
    var query = builder;
    query = query.where('Entry', key.entry);
    query = query.where('Item', key.item);
    return query;
  }
}

final class MillingLootTemplateFilter {
  final String entry;
  final String name;

  const MillingLootTemplateFilter({this.entry = '', this.name = ''});

  factory MillingLootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return MillingLootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  MillingLootTemplateFilter copyWith({String? entry, String? name}) {
    return MillingLootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
