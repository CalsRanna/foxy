// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glyph_property_repository.dart';

final class GlyphPropertyFilter {
  final String id;

  const GlyphPropertyFilter({this.id = ''});

  factory GlyphPropertyFilter.fromJson(Map<String, dynamic> json) {
    return GlyphPropertyFilter(id: json['id']?.toString() ?? '');
  }

  GlyphPropertyFilter copyWith({String? id}) {
    return GlyphPropertyFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
