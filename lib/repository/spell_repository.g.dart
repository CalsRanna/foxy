// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_repository.dart';

final class SpellFilter {
  final String id;
  final String name;

  const SpellFilter({this.id = '', this.name = ''});

  factory SpellFilter.fromJson(Map<String, dynamic> json) {
    return SpellFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SpellFilter copyWith({String? id, String? name}) {
    return SpellFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
