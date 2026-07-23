// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefCharTitleEntity {
  final int id;
  final String nameLangZhCN;

  const BriefCharTitleEntity({this.id = 0, this.nameLangZhCN = ''});

  factory BriefCharTitleEntity.fromJson(Map<String, dynamic> json) {
    return BriefCharTitleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      nameLangZhCN: json['Name_lang_zhCN']?.toString() ?? '',
    );
  }

  int get key => id;
}
