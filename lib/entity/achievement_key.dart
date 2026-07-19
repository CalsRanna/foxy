import 'package:foxy/entity/achievement_entity.dart';

class AchievementKey {
  final int id;

  const AchievementKey({required this.id});

  factory AchievementKey.fromEntity(AchievementEntity entity) {
    return AchievementKey(id: entity.id);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AchievementKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
