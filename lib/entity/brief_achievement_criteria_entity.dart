import 'package:foxy/entity/achievement_criteria_key.dart';

class BriefAchievementCriteriaEntity {
  final int id;
  final int achievementId;
  final int type;
  final String descriptionLangZhCN;

  const BriefAchievementCriteriaEntity({
    this.id = 0,
    this.achievementId = 0,
    this.type = 0,
    this.descriptionLangZhCN = '',
  });

  factory BriefAchievementCriteriaEntity.fromJson(Map<String, dynamic> json) {
    return BriefAchievementCriteriaEntity(
      id: json['ID'] ?? 0,
      achievementId: json['Achievement_ID'] ?? 0,
      type: json['Type'] ?? 0,
      descriptionLangZhCN: json['Description_lang_zhCN'] ?? '',
    );
  }

  AchievementCriteriaKey get key => AchievementCriteriaKey(id: id);
}
