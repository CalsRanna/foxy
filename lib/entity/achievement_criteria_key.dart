import 'package:foxy/entity/achievement_criteria_entity.dart';

class AchievementCriteriaKey {
  final int id;

  const AchievementCriteriaKey({required this.id});

  factory AchievementCriteriaKey.fromEntity(AchievementCriteriaEntity entity) =>
      AchievementCriteriaKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AchievementCriteriaKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
