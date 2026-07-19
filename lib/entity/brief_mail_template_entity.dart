import 'package:foxy/entity/mail_template_key.dart';

class BriefMailTemplateEntity {
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
      id: json['ID'] ?? 0,
      subjectLangZhCN: json['Subject_lang_zhCN'] ?? '',
      bodyLangZhCN: json['Body_lang_zhCN'] ?? '',
    );
  }

  MailTemplateKey get key => MailTemplateKey(id: id);
}
