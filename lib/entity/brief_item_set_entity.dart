class BriefItemSetEntity {
  final int id;
  final String nameLangZhCN;
  final int requiredSkill;
  final int requiredSkillRank;

  const BriefItemSetEntity({
    this.id = 0,
    this.nameLangZhCN = '',
    this.requiredSkill = 0,
    this.requiredSkillRank = 0,
  });

  factory BriefItemSetEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemSetEntity(
      id: json['ID'] ?? 0,
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
      requiredSkill: json['RequiredSkill'] ?? 0,
      requiredSkillRank: json['RequiredSkillRank'] ?? 0,
    );
  }

  int get key => id;
}
