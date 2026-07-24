// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_template_repository.dart';

final class ItemTemplateFilter {
  final String entry;
  final String name;
  final String description;
  final int classId;
  final int subclass;

  const ItemTemplateFilter({
    this.entry = '',
    this.name = '',
    this.description = '',
    this.classId = -1,
    this.subclass = -1,
  });

  factory ItemTemplateFilter.fromJson(Map<String, dynamic> json) {
    return ItemTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      classId: (json['classId'] as num?)?.toInt() ?? -1,
      subclass: (json['subclass'] as num?)?.toInt() ?? -1,
    );
  }

  ItemTemplateFilter copyWith({
    String? entry,
    String? name,
    String? description,
    int? classId,
    int? subclass,
  }) {
    return ItemTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
      description: description ?? this.description,
      classId: classId ?? this.classId,
      subclass: subclass ?? this.subclass,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'name': name,
      'description': description,
      'classId': classId,
      'subclass': subclass,
    };
  }
}
