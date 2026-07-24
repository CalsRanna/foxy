// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_icon_repository.dart';

final class SpellIconFilter {
  final String id;
  final String name;

  const SpellIconFilter({this.id = '', this.name = ''});

  factory SpellIconFilter.fromJson(Map<String, dynamic> json) {
    return SpellIconFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SpellIconFilter copyWith({String? id, String? name}) {
    return SpellIconFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
