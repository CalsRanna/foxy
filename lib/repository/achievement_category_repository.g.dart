// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_category_repository.dart';

final class AchievementCategoryFilter {
  final String id;
  final String name;

  const AchievementCategoryFilter({this.id = '', this.name = ''});

  factory AchievementCategoryFilter.fromJson(Map<String, dynamic> json) {
    return AchievementCategoryFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  AchievementCategoryFilter copyWith({String? id, String? name}) {
    return AchievementCategoryFilter(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
