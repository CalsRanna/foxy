// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefQuestSortEntity {
  final int id;
  final String sortNameLangZhCN;

  const BriefQuestSortEntity({this.id = 0, this.sortNameLangZhCN = ''});

  factory BriefQuestSortEntity.fromJson(Map<String, dynamic> json) {
    return BriefQuestSortEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      sortNameLangZhCN: json['SortName_lang_zhCN']?.toString() ?? '',
    );
  }

  int get key => id;
}
