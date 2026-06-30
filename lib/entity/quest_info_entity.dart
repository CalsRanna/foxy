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

  QuestInfoEntity copyWith({int? id, String? infoNameLangZhCn}) {
    return QuestInfoEntity(
      id: id ?? this.id,
      infoNameLangZhCn: infoNameLangZhCn ?? this.infoNameLangZhCn,
    );
  }
}
