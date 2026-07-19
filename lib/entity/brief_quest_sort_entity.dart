import 'package:foxy/entity/quest_sort_key.dart';

class BriefQuestSortEntity {
  final int id;
  final String sortNameLangZhCN;

  const BriefQuestSortEntity({this.id = 0, this.sortNameLangZhCN = ''});

  factory BriefQuestSortEntity.fromJson(Map<String, dynamic> json) {
    return BriefQuestSortEntity(
      id: json['ID'] ?? 0,
      sortNameLangZhCN: json['SortName_lang_zhCN'] ?? '',
    );
  }

  QuestSortKey get key => QuestSortKey(id: id);
}
