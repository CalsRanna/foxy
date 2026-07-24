// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefAchievementCategoryEntity {
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
      id: (json['ID'] as num?)?.toInt() ?? 0,
      parent: (json['Parent'] as num?)?.toInt() ?? -1,
      nameLangZhCN: json['Name_lang_zhCN']?.toString() ?? '',
      uiOrder: (json['Ui_order'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
