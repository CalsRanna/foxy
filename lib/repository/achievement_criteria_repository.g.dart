// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_criteria_repository.dart';

final class AchievementCriteriaFilter {
  final String id;
  final String achievementId;
  final String type;
  final String description;

  const AchievementCriteriaFilter({
    this.id = '',
    this.achievementId = '',
    this.type = '',
    this.description = '',
  });

  factory AchievementCriteriaFilter.fromJson(Map<String, dynamic> json) {
    return AchievementCriteriaFilter(
      id: json['id']?.toString() ?? '',
      achievementId: json['achievementId']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }

  AchievementCriteriaFilter copyWith({
    String? id,
    String? achievementId,
    String? type,
    String? description,
  }) {
    return AchievementCriteriaFilter(
      id: id ?? this.id,
      achievementId: achievementId ?? this.achievementId,
      type: type ?? this.type,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'achievementId': achievementId,
      'type': type,
      'description': description,
    };
  }
}
