class QuestInfo {
  int id = 0;
  String infoNameLangZhCn = '';

  QuestInfo();

  QuestInfo.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? 0;
    infoNameLangZhCn = json['InfoName_Lang_zhCN'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'InfoName_Lang_zhCN': infoNameLangZhCn,
    };
  }
}
