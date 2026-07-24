// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disenchant_loot_template_repository.dart';

mixin _DisenchantLootTemplateRepositoryMixin on RepositoryMixin {
  QueryBuilder _whereKey(QueryBuilder builder, DisenchantLootTemplateKey key) {
    var query = builder;
    query = query.where('Entry', key.entry);
    query = query.where('Item', key.item);
    return query;
  }
}

final class DisenchantLootTemplateFilter {
  final String entry;
  final String name;

  const DisenchantLootTemplateFilter({this.entry = '', this.name = ''});

  factory DisenchantLootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return DisenchantLootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  DisenchantLootTemplateFilter copyWith({String? entry, String? name}) {
    return DisenchantLootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
