// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickpocketing_loot_template_repository.dart';

mixin _PickpocketingLootTemplateRepositoryMixin on RepositoryMixin {
  QueryBuilder _whereKey(
    QueryBuilder builder,
    PickpocketingLootTemplateKey key,
  ) {
    var query = builder;
    query = query.where('Entry', key.entry);
    query = query.where('Item', key.item);
    return query;
  }
}

final class PickpocketingLootTemplateFilter {
  final String entry;
  final String name;

  const PickpocketingLootTemplateFilter({this.entry = '', this.name = ''});

  factory PickpocketingLootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return PickpocketingLootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  PickpocketingLootTemplateFilter copyWith({String? entry, String? name}) {
    return PickpocketingLootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
