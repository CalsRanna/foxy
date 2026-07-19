import 'package:foxy/entity/quest_request_items_locale_key.dart';

/// 任务请求物品本地化列表展示模型。
class BriefQuestRequestItemsLocaleEntity {
  final int id;
  final String locale;
  final String completionText;

  const BriefQuestRequestItemsLocaleEntity({
    this.id = 0,
    this.locale = 'zhCN',
    this.completionText = '',
  });

  factory BriefQuestRequestItemsLocaleEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefQuestRequestItemsLocaleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? 'zhCN',
      completionText: json['CompletionText']?.toString() ?? '',
    );
  }

  QuestRequestItemsLocaleKey get key =>
      QuestRequestItemsLocaleKey(id: id, locale: locale);
}
