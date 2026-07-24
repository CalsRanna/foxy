// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_loot_template_repository.dart';

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
