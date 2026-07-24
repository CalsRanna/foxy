// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milling_loot_template_repository.dart';

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
