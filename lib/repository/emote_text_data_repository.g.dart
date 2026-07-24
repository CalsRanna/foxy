// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emote_text_data_repository.dart';

final class EmoteTextDataFilter {
  final String id;
  final String text;

  const EmoteTextDataFilter({this.id = '', this.text = ''});

  factory EmoteTextDataFilter.fromJson(Map<String, dynamic> json) {
    return EmoteTextDataFilter(
      id: json['id']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
    );
  }

  EmoteTextDataFilter copyWith({String? id, String? text}) {
    return EmoteTextDataFilter(id: id ?? this.id, text: text ?? this.text);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text};
  }
}
