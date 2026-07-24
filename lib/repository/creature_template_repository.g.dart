// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_repository.dart';

final class CreatureTemplateFilter {
  final String entry;
  final String name;
  final String subName;

  const CreatureTemplateFilter({
    this.entry = '',
    this.name = '',
    this.subName = '',
  });

  factory CreatureTemplateFilter.fromJson(Map<String, dynamic> json) {
    return CreatureTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      subName: json['subName']?.toString() ?? '',
    );
  }

  CreatureTemplateFilter copyWith({
    String? entry,
    String? name,
    String? subName,
  }) {
    return CreatureTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
      subName: subName ?? this.subName,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name, 'subName': subName};
  }
}
