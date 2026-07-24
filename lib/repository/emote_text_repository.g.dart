// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emote_text_repository.dart';

final class EmoteTextFilter {
  final String id;
  final String name;

  const EmoteTextFilter({this.id = '', this.name = ''});

  factory EmoteTextFilter.fromJson(Map<String, dynamic> json) {
    return EmoteTextFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  EmoteTextFilter copyWith({String? id, String? name}) {
    return EmoteTextFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
