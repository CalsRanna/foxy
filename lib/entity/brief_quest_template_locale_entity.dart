import 'package:foxy/entity/quest_template_locale_key.dart';

/// 任务模板本地化列表展示模型。
class BriefQuestTemplateLocaleEntity {
  final int id;
  final String locale;
  final String title;

  const BriefQuestTemplateLocaleEntity({
    this.id = 0,
    this.locale = 'zhCN',
    this.title = '',
  });

  factory BriefQuestTemplateLocaleEntity.fromJson(Map<String, dynamic> json) {
    return BriefQuestTemplateLocaleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? 'zhCN',
      title: json['Title']?.toString() ?? '',
    );
  }

  QuestTemplateLocaleKey get key =>
      QuestTemplateLocaleKey(id: id, locale: locale);
}
