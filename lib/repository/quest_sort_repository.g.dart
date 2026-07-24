// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_sort_repository.dart';

final class QuestSortFilter {
  final String id;
  final String name;

  const QuestSortFilter({this.id = '', this.name = ''});

  factory QuestSortFilter.fromJson(Map<String, dynamic> json) {
    return QuestSortFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  QuestSortFilter copyWith({String? id, String? name}) {
    return QuestSortFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
