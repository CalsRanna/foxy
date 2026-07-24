// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_info_repository.dart';

final class QuestInfoFilter {
  final String id;
  final String name;

  const QuestInfoFilter({this.id = '', this.name = ''});

  factory QuestInfoFilter.fromJson(Map<String, dynamic> json) {
    return QuestInfoFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  QuestInfoFilter copyWith({String? id, String? name}) {
    return QuestInfoFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
