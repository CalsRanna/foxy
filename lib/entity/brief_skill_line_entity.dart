class BriefSkillLineEntity {
  final int id;
  final int categoryId;
  final String displayNameZhCN;

  const BriefSkillLineEntity({
    this.id = 0,
    this.categoryId = 0,
    this.displayNameZhCN = '',
  });

  factory BriefSkillLineEntity.fromJson(Map<String, dynamic> json) =>
      BriefSkillLineEntity(
        id: json['ID'] ?? 0,
        categoryId: json['CategoryID'] ?? 0,
        displayNameZhCN: json['DisplayName_lang_zhCN'] ?? '',
      );

  int get key => id;
}
