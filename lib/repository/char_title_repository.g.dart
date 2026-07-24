// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'char_title_repository.dart';

final class CharTitleFilter {
  final String id;
  final String name;

  const CharTitleFilter({this.id = '', this.name = ''});

  factory CharTitleFilter.fromJson(Map<String, dynamic> json) {
    return CharTitleFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  CharTitleFilter copyWith({String? id, String? name}) {
    return CharTitleFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
