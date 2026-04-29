class QuestInfo {
  final int id;
  final String infoNameLangZhCn;

  const QuestInfo({this.id = 0, this.infoNameLangZhCn = ''});

  factory QuestInfo.fromJson(Map<String, dynamic> json) {
    return QuestInfo(
      id: json['ID'] ?? 0,
      infoNameLangZhCn: json['InfoName_Lang_zhCN'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'InfoName_Lang_zhCN': infoNameLangZhCn,
    };
  }
}
