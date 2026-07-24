// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefAchievementCriteriaEntity {
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
      id: (json['ID'] as num?)?.toInt() ?? 0,
      achievementId: (json['Achievement_ID'] as num?)?.toInt() ?? 0,
      type: (json['Type'] as num?)?.toInt() ?? 0,
      descriptionLangZhCN: json['Description_lang_zhCN']?.toString() ?? '',
    );
  }

  int get key => id;
}
