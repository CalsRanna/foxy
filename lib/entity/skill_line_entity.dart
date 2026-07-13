class SkillLineEntity {
  final Map<String, dynamic> values;

  SkillLineEntity.fromJson(Map<String, dynamic> json)
    : values = Map.unmodifiable(Map<String, dynamic>.from(json));

  int get id => values['ID'] ?? 0;
  String get displayNameZhCN => values['DisplayName_lang_zhCN'] ?? '';
  int get categoryId => values['CategoryID'] ?? 0;

  Map<String, dynamic> toJson() => Map<String, dynamic>.from(values);
}

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
}
