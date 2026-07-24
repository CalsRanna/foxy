// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skinning_loot_template_repository.dart';

mixin _SkinningLootTemplateRepositoryMixin on RepositoryMixin {
  QueryBuilder _whereKey(QueryBuilder builder, SkinningLootTemplateKey key) {
    var query = builder;
    query = query.where('Entry', key.entry);
    query = query.where('Item', key.item);
    return query;
  }
}

final class SkinningLootTemplateFilter {
  final String entry;
  final String name;

  const SkinningLootTemplateFilter({this.entry = '', this.name = ''});

  factory SkinningLootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return SkinningLootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SkinningLootTemplateFilter copyWith({String? entry, String? name}) {
    return SkinningLootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
