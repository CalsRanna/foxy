// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_text_repository.dart';

final class PageTextFilter {
  final String id;
  final String text;

  const PageTextFilter({this.id = '', this.text = ''});

  factory PageTextFilter.fromJson(Map<String, dynamic> json) {
    return PageTextFilter(
      id: json['id']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
    );
  }

  PageTextFilter copyWith({String? id, String? text}) {
    return PageTextFilter(id: id ?? this.id, text: text ?? this.text);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text};
  }
}
