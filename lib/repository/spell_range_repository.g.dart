// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_range_repository.dart';

final class SpellRangeFilter {
  final String id;
  final String name;

  const SpellRangeFilter({this.id = '', this.name = ''});

  factory SpellRangeFilter.fromJson(Map<String, dynamic> json) {
    return SpellRangeFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SpellRangeFilter copyWith({String? id, String? name}) {
    return SpellRangeFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
