// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_repository.dart';

final class AchievementFilter {
  final String id;
  final String title;

  const AchievementFilter({this.id = '', this.title = ''});

  factory AchievementFilter.fromJson(Map<String, dynamic> json) {
    return AchievementFilter(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
    );
  }

  AchievementFilter copyWith({String? id, String? title}) {
    return AchievementFilter(id: id ?? this.id, title: title ?? this.title);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title};
  }
}
