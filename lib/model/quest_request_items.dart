// QuestRequestItems 模型
// quest_request_items 表，1:1 关系与 quest_template，共享 ID 主键。

class QuestRequestItems {
  int id = 0;
  int emoteOnComplete = 0;
  int emoteOnIncomplete = 0;
  String completionText = '';
  int? verifiedBuild;

  QuestRequestItems();

  QuestRequestItems.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? 0;
    emoteOnComplete = json['EmoteOnComplete'] ?? 0;
    emoteOnIncomplete = json['EmoteOnIncomplete'] ?? 0;
    completionText = json['CompletionText']?.toString() ?? '';
    verifiedBuild = json['VerifiedBuild'];
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      'ID': id,
      'EmoteOnComplete': emoteOnComplete,
      'EmoteOnIncomplete': emoteOnIncomplete,
      'CompletionText': completionText,
    };
    if (verifiedBuild != null) {
      result['VerifiedBuild'] = verifiedBuild!;
    }
    return result;
  }
}

/// quest_request_items_locale 本地化模型（复合键: ID + Locale）
class QuestRequestItemsLocale {
  int id = 0;
  String locale = 'zhCN';
  String completionText = '';
  int? verifiedBuild;

  QuestRequestItemsLocale();

  QuestRequestItemsLocale.fromJson(Map<String, dynamic> json) {
    id = (json['ID'] ?? json['id'] ?? 0) as int;
    locale = json['Locale']?.toString() ?? 'zhCN';
    completionText = json['CompletionText']?.toString() ?? '';
    verifiedBuild = json['VerifiedBuild'];
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      'ID': id,
      'Locale': locale,
      'CompletionText': completionText,
    };
    if (verifiedBuild != null) {
      result['VerifiedBuild'] = verifiedBuild!;
    }
    return result;
  }
}
