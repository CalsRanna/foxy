class BriefAchievementEntity {
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
      id: json['ID'] ?? 0,
      titleLangZhCN: json['Title_lang_zhCN'] ?? '',
      descriptionLangZhCN: json['Description_lang_zhCN'] ?? '',
      rewardLangZhCN: json['Reward_lang_zhCN'] ?? '',
    );
  }

  int get key => id;
}
