import 'package:foxy/entity/achievement_category_key.dart';

class BriefAchievementCategoryEntity {
  final int id;
  final int parent;
  final String nameLangZhCN;
  final int uiOrder;

  const BriefAchievementCategoryEntity({
    this.id = 0,
    this.parent = -1,
    this.nameLangZhCN = '',
    this.uiOrder = 0,
  });

  factory BriefAchievementCategoryEntity.fromJson(Map<String, dynamic> json) {
    return BriefAchievementCategoryEntity(
      id: json['ID'] ?? 0,
      parent: json['Parent'] ?? -1,
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
      uiOrder: json['Ui_order'] ?? 0,
    );
  }

  AchievementCategoryKey get key => AchievementCategoryKey(id: id);
}
