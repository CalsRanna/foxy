// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prospecting_loot_template_repository.dart';

final class ProspectingLootTemplateFilter {
  final String entry;
  final String name;

  const ProspectingLootTemplateFilter({this.entry = '', this.name = ''});

  factory ProspectingLootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return ProspectingLootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ProspectingLootTemplateFilter copyWith({String? entry, String? name}) {
    return ProspectingLootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
