// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_text_repository.dart';

final class NpcTextFilter {
  final String id;
  final String text;

  const NpcTextFilter({this.id = '', this.text = ''});

  factory NpcTextFilter.fromJson(Map<String, dynamic> json) {
    return NpcTextFilter(
      id: json['id']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
    );
  }

  NpcTextFilter copyWith({String? id, String? text}) {
    return NpcTextFilter(id: id ?? this.id, text: text ?? this.text);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text};
  }
}
