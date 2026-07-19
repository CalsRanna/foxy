class BriefQuestInfoEntity {
  final int id;
  final String infoNameLangZhCN;

  const BriefQuestInfoEntity({this.id = 0, this.infoNameLangZhCN = ''});

  factory BriefQuestInfoEntity.fromJson(Map<String, dynamic> json) {
    return BriefQuestInfoEntity(
      id: json['ID'] ?? 0,
      infoNameLangZhCN: json['InfoName_lang_zhCN'] ?? '',
    );
  }

  int get key => id;
}
