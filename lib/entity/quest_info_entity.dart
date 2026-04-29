class QuestInfoEntity {
  final int id;
  final String infoNameLangZhCn;

  const QuestInfoEntity({this.id = 0, this.infoNameLangZhCn = ''});

  factory QuestInfoEntity.fromJson(Map<String, dynamic> json) {
    return QuestInfoEntity(
      id: json['ID'] ?? 0,
      infoNameLangZhCn: json['InfoName_Lang_zhCN'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'InfoName_Lang_zhCN': infoNameLangZhCn};
  }
}
