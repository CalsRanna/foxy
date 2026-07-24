// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_line_repository.dart';

final class SkillLineFilter {
  final String id;
  final String name;

  const SkillLineFilter({this.id = '', this.name = ''});

  factory SkillLineFilter.fromJson(Map<String, dynamic> json) {
    return SkillLineFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SkillLineFilter copyWith({String? id, String? name}) {
    return SkillLineFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
