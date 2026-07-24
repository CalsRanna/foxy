// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefItemSetEntity {
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
      id: (json['ID'] as num?)?.toInt() ?? 0,
      nameLangZhCN: json['Name_lang_zhCN']?.toString() ?? '',
      requiredSkill: (json['RequiredSkill'] as num?)?.toInt() ?? 0,
      requiredSkillRank: (json['RequiredSkillRank'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
