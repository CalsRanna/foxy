// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefEmoteTextDataEntity {
  final int id;
  final String textLangZhCN;

  const BriefEmoteTextDataEntity({this.id = 0, this.textLangZhCN = ''});

  factory BriefEmoteTextDataEntity.fromJson(Map<String, dynamic> json) {
    return BriefEmoteTextDataEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      textLangZhCN: json['Text_lang_zhCN']?.toString() ?? '',
    );
  }

  int get key => id;
}
