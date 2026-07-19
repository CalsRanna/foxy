import 'package:foxy/entity/achievement_category_entity.dart';

class AchievementCategoryKey {
  final int id;

  const AchievementCategoryKey({required this.id});

  factory AchievementCategoryKey.fromEntity(AchievementCategoryEntity entity) =>
      AchievementCategoryKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AchievementCategoryKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
