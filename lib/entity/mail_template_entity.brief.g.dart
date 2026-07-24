// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefMailTemplateEntity {
  final int id;
  final String subjectLangZhCN;
  final String bodyLangZhCN;

  const BriefMailTemplateEntity({
    this.id = 0,
    this.subjectLangZhCN = '',
    this.bodyLangZhCN = '',
  });

  factory BriefMailTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefMailTemplateEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      subjectLangZhCN: json['Subject_lang_zhCN']?.toString() ?? '',
      bodyLangZhCN: json['Body_lang_zhCN']?.toString() ?? '',
    );
  }

  int get key => id;
}
