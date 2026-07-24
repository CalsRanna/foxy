// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_template_repository.dart';

final class GameObjectTemplateFilter {
  final String entry;
  final String name;

  const GameObjectTemplateFilter({this.entry = '', this.name = ''});

  factory GameObjectTemplateFilter.fromJson(Map<String, dynamic> json) {
    return GameObjectTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  GameObjectTemplateFilter copyWith({String? entry, String? name}) {
    return GameObjectTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
