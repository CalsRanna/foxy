// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbc_faction_repository.dart';

final class DbcFactionFilter {
  final String id;
  final String name;

  const DbcFactionFilter({this.id = '', this.name = ''});

  factory DbcFactionFilter.fromJson(Map<String, dynamic> json) {
    return DbcFactionFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  DbcFactionFilter copyWith({String? id, String? name}) {
    return DbcFactionFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
