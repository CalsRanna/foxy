// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefAchievementEntity {
  final int id;
  final String titleLangZhCN;
  final String descriptionLangZhCN;
  final String rewardLangZhCN;

  const BriefAchievementEntity({
    this.id = 0,
    this.titleLangZhCN = '',
    this.descriptionLangZhCN = '',
    this.rewardLangZhCN = '',
  });

  factory BriefAchievementEntity.fromJson(Map<String, dynamic> json) {
    return BriefAchievementEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      titleLangZhCN: json['Title_lang_zhCN']?.toString() ?? '',
      descriptionLangZhCN: json['Description_lang_zhCN']?.toString() ?? '',
      rewardLangZhCN: json['Reward_lang_zhCN']?.toString() ?? '',
    );
  }

  int get key => id;
}
