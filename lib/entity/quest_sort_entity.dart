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

  QuestSortEntity copyWith({int? id, String? sortNameLangZhCn}) {
    return QuestSortEntity(
      id: id ?? this.id,
      sortNameLangZhCn: sortNameLangZhCn ?? this.sortNameLangZhCn,
    );
  }
}

/// 任务排序列表/Picker 展示模型
class BriefQuestSortEntity {
  final int id;
  final String sortNameLangZhCn;

  const BriefQuestSortEntity({this.id = 0, this.sortNameLangZhCn = ''});

  factory BriefQuestSortEntity.fromJson(Map<String, dynamic> json) {
    return BriefQuestSortEntity(
      id: json['ID'] ?? 0,
      sortNameLangZhCn: json['SortName_Lang_zhCN'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'SortName_Lang_zhCN': sortNameLangZhCn};
  }

  BriefQuestSortEntity copyWith({int? id, String? sortNameLangZhCn}) {
    return BriefQuestSortEntity(
      id: id ?? this.id,
      sortNameLangZhCn: sortNameLangZhCn ?? this.sortNameLangZhCn,
    );
  }
}
