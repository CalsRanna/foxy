// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gem_property_repository.dart';

final class GemPropertyFilter {
  final String id;

  const GemPropertyFilter({this.id = ''});

  factory GemPropertyFilter.fromJson(Map<String, dynamic> json) {
    return GemPropertyFilter(id: json['id']?.toString() ?? '');
  }

  GemPropertyFilter copyWith({String? id}) {
    return GemPropertyFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
