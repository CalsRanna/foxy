// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skinning_loot_template_repository.dart';

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
