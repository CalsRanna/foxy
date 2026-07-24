// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_focus_object_repository.dart';

final class SpellFocusObjectFilter {
  final String id;
  final String name;

  const SpellFocusObjectFilter({this.id = '', this.name = ''});

  factory SpellFocusObjectFilter.fromJson(Map<String, dynamic> json) {
    return SpellFocusObjectFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SpellFocusObjectFilter copyWith({String? id, String? name}) {
    return SpellFocusObjectFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
