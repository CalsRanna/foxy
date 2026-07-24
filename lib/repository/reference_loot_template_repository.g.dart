// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference_loot_template_repository.dart';

mixin _ReferenceLootTemplateRepositoryMixin on RepositoryMixin {
  QueryBuilder _whereKey(QueryBuilder builder, ReferenceLootTemplateKey key) {
    var query = builder;
    query = query.where('Entry', key.entry);
    query = query.where('Item', key.item);
    return query;
  }
}

final class ReferenceLootTemplateFilter {
  final String entry;
  final String name;

  const ReferenceLootTemplateFilter({this.entry = '', this.name = ''});

  factory ReferenceLootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return ReferenceLootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ReferenceLootTemplateFilter copyWith({String? entry, String? name}) {
    return ReferenceLootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
