// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbc_faction_template_repository.dart';

final class DbcFactionTemplateFilter {
  final String id;
  final String faction;
  final String name;

  const DbcFactionTemplateFilter({
    this.id = '',
    this.faction = '',
    this.name = '',
  });

  factory DbcFactionTemplateFilter.fromJson(Map<String, dynamic> json) {
    return DbcFactionTemplateFilter(
      id: json['id']?.toString() ?? '',
      faction: json['faction']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  DbcFactionTemplateFilter copyWith({
    String? id,
    String? faction,
    String? name,
  }) {
    return DbcFactionTemplateFilter(
      id: id ?? this.id,
      faction: faction ?? this.faction,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'faction': faction, 'name': name};
  }
}
