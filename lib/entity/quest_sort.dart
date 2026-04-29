class QuestSort {
  final int id;
  final String sortNameLangZhCn;

  const QuestSort({this.id = 0, this.sortNameLangZhCn = ''});

  factory QuestSort.fromJson(Map<String, dynamic> json) {
    return QuestSort(
      id: json['ID'] ?? 0,
      sortNameLangZhCn: json['SortName_Lang_zhCN'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'SortName_Lang_zhCN': sortNameLangZhCn,
    };
  }
}
