class QuestInfo {
  int id = 0;
  String infoNameLangZhCn = '';

  QuestInfo();

  factory QuestInfo.fromJson(Map<String, dynamic> json) {
    return QuestInfo()
      ..id = json['ID'] ?? 0
      ..infoNameLangZhCn = json['InfoName_Lang_zhCN'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'InfoName_Lang_zhCN': infoNameLangZhCn,
    };
  }
}
