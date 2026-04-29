// QuestRequestItems 模型
// quest_request_items 表，1:1 关系与 quest_template，共享 ID 主键。

class QuestRequestItems {
  final int id;
  final int emoteOnComplete;
  final int emoteOnIncomplete;
  final String completionText;
  final int? verifiedBuild;

  const QuestRequestItems({
    this.id = 0,
    this.emoteOnComplete = 0,
    this.emoteOnIncomplete = 0,
    this.completionText = '',
    this.verifiedBuild,
  });

  factory QuestRequestItems.fromJson(Map<String, dynamic> json) {
    return QuestRequestItems(
      id: json['ID'] ?? 0,
      emoteOnComplete: json['EmoteOnComplete'] ?? 0,
      emoteOnIncomplete: json['EmoteOnIncomplete'] ?? 0,
      completionText: json['CompletionText']?.toString() ?? '',
      verifiedBuild: json['VerifiedBuild'],
    );
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
  final int id;
  final String locale;
  final String completionText;
  final int? verifiedBuild;

  const QuestRequestItemsLocale({
    this.id = 0,
    this.locale = 'zhCN',
    this.completionText = '',
    this.verifiedBuild,
  });

  factory QuestRequestItemsLocale.fromJson(Map<String, dynamic> json) {
    return QuestRequestItemsLocale(
      id: (json['ID'] ?? json['id'] ?? 0) as int,
      locale: json['Locale']?.toString() ?? 'zhCN',
      completionText: json['CompletionText']?.toString() ?? '',
      verifiedBuild: json['VerifiedBuild'],
    );
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
