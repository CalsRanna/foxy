// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefQuestInfoEntity {
  final int id;
  final String infoNameLangZhCN;

  const BriefQuestInfoEntity({this.id = 0, this.infoNameLangZhCN = ''});

  factory BriefQuestInfoEntity.fromJson(Map<String, dynamic> json) {
    return BriefQuestInfoEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      infoNameLangZhCN: json['InfoName_lang_zhCN']?.toString() ?? '',
    );
  }

  int get key => id;
}
