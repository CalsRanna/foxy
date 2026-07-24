// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefCurrencyCategoryEntity {
  final int id;
  final int flags;
  final String nameLangZhCN;

  const BriefCurrencyCategoryEntity({
    this.id = 0,
    this.flags = 0,
    this.nameLangZhCN = '',
  });

  factory BriefCurrencyCategoryEntity.fromJson(Map<String, dynamic> json) {
    return BriefCurrencyCategoryEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      nameLangZhCN: json['Name_lang_zhCN']?.toString() ?? '',
    );
  }

  int get key => id;
}
