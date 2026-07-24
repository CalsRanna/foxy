// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_loot_template_repository.dart';

final class GameObjectLootTemplateFilter {
  final String entry;
  final String name;

  const GameObjectLootTemplateFilter({this.entry = '', this.name = ''});

  factory GameObjectLootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return GameObjectLootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  GameObjectLootTemplateFilter copyWith({String? entry, String? name}) {
    return GameObjectLootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
