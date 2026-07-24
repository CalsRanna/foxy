// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefDbcFactionEntity {
  final int id;
  final String nameLangZhCN;
  final String descriptionLangZhCN;

  const BriefDbcFactionEntity({
    this.id = 0,
    this.nameLangZhCN = '',
    this.descriptionLangZhCN = '',
  });

  factory BriefDbcFactionEntity.fromJson(Map<String, dynamic> json) {
    return BriefDbcFactionEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      nameLangZhCN: json['Name_lang_zhCN']?.toString() ?? '',
      descriptionLangZhCN: json['Description_lang_zhCN']?.toString() ?? '',
    );
  }

  int get key => id;
}
