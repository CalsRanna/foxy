/// 任务请求物品文本列表/Picker 展示模型
class BriefQuestRequestItemsEntity {
  final int id;
  final int emoteOnComplete;
  final int emoteOnIncomplete;
  final String completionText;

  const BriefQuestRequestItemsEntity({
    this.id = 0,
    this.emoteOnComplete = 0,
    this.emoteOnIncomplete = 0,
    this.completionText = '',
  });

  factory BriefQuestRequestItemsEntity.fromJson(Map<String, dynamic> json) {
    return BriefQuestRequestItemsEntity(
      id: json['ID'] ?? 0,
      emoteOnComplete: json['EmoteOnComplete'] ?? 0,
      emoteOnIncomplete: json['EmoteOnIncomplete'] ?? 0,
      completionText: json['CompletionText']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'EmoteOnComplete': emoteOnComplete,
      'EmoteOnIncomplete': emoteOnIncomplete,
      'CompletionText': completionText,
    };
  }
}

/// QuestRequestItems 模型
/// quest_request_items 表，1:1 关系与 quest_template，共享 ID 主键。
class QuestRequestItemsEntity {
  final int id;
  final int emoteOnComplete;
  final int emoteOnIncomplete;
  final String completionText;
  final int verifiedBuild;

  const QuestRequestItemsEntity({
    this.id = 0,
    this.emoteOnComplete = 0,
    this.emoteOnIncomplete = 0,
    this.completionText = '',
    this.verifiedBuild = 0,
  });

  factory QuestRequestItemsEntity.fromJson(Map<String, dynamic> json) {
    return QuestRequestItemsEntity(
      id: json['ID'] ?? 0,
      emoteOnComplete: json['EmoteOnComplete'] ?? 0,
      emoteOnIncomplete: json['EmoteOnIncomplete'] ?? 0,
      completionText: json['CompletionText']?.toString() ?? '',
      verifiedBuild: json['VerifiedBuild'] ?? 0,
    );
  }

  QuestRequestItemsEntity copyWith({
    int? id,
    int? emoteOnComplete,
    int? emoteOnIncomplete,
    String? completionText,
    int? verifiedBuild,
  }) {
    return QuestRequestItemsEntity(
      id: id ?? this.id,
      emoteOnComplete: emoteOnComplete ?? this.emoteOnComplete,
      emoteOnIncomplete: emoteOnIncomplete ?? this.emoteOnIncomplete,
      completionText: completionText ?? this.completionText,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      'ID': id,
      'EmoteOnComplete': emoteOnComplete,
      'EmoteOnIncomplete': emoteOnIncomplete,
      'CompletionText': completionText,
      'VerifiedBuild': verifiedBuild,
    };
    return result;
  }
}

/// quest_request_items_locale 本地化模型（复合键: ID + Locale）
class QuestRequestItemsLocaleEntity {
  final int id;
  final String locale;
  final String completionText;
  final int verifiedBuild;

  const QuestRequestItemsLocaleEntity({
    this.id = 0,
    this.locale = 'zhCN',
    this.completionText = '',
    this.verifiedBuild = 0,
  });

  factory QuestRequestItemsLocaleEntity.fromJson(Map<String, dynamic> json) {
    return QuestRequestItemsLocaleEntity(
      id: (json['ID'] ?? json['id'] ?? 0) as int,
      locale: json['locale']?.toString() ?? 'zhCN',
      completionText: json['CompletionText']?.toString() ?? '',
      verifiedBuild: json['VerifiedBuild'] ?? 0,
    );
  }

  QuestRequestItemsLocaleEntity copyWith({
    int? id,
    String? locale,
    String? completionText,
    int? verifiedBuild,
  }) {
    return QuestRequestItemsLocaleEntity(
      id: id ?? this.id,
      locale: locale ?? this.locale,
      completionText: completionText ?? this.completionText,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      'ID': id,
      'locale': locale,
      'CompletionText': completionText,
      'VerifiedBuild': verifiedBuild,
    };
    return result;
  }
}
