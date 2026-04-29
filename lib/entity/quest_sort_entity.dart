class QuestSortEntity {
  final int id;
  final String sortNameLangZhCn;

  const QuestSortEntity({this.id = 0, this.sortNameLangZhCn = ''});

  factory QuestSortEntity.fromJson(Map<String, dynamic> json) {
    return QuestSortEntity(
      id: json['ID'] ?? 0,
      sortNameLangZhCn: json['SortName_Lang_zhCN'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'SortName_Lang_zhCN': sortNameLangZhCn};
  }
}
