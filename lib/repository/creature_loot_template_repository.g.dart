// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_loot_template_repository.dart';

mixin _CreatureLootTemplateRepositoryMixin on RepositoryMixin {
  QueryBuilder _whereKey(QueryBuilder builder, CreatureLootTemplateKey key) {
    var query = builder;
    query = query.where('Entry', key.entry);
    query = query.where('Item', key.item);
    query = query.where('Reference', key.reference);
    query = query.where('GroupId', key.groupId);
    return query;
  }
}

final class CreatureLootTemplateFilter {
  final String entry;
  final String name;

  const CreatureLootTemplateFilter({this.entry = '', this.name = ''});

  factory CreatureLootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return CreatureLootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  CreatureLootTemplateFilter copyWith({String? entry, String? name}) {
    return CreatureLootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
